initCobraToolbox();

changeCobraSolver('gurobi','all');
setRavenSolver('gurobi');

data = readtable('TPM_normalized_data_final.csv');
data_struct.tissues = data.Properties.VariableNames(2:end)';  % sample (tissue) names
data_struct.genes = data.genes;  % gene names
data_struct.levels = table2array(data(:, 2:end));  % gene TPM values
data_struct.threshold = 1;
load('Human-GEM.mat');
ihuman = addBoundaryMets(ihuman);
%%
essentialTasks = parseTaskList('metabolicTasks_Essential_xlsx.xlsx');
checkTasks(ihuman, [], true, false, false, essentialTasks);

refModel = ihuman;  % the reference model from which the GEM will be extracted
celltype = [];  % used if tissues are subdivided into cell type, which is not the case here
hpaData = [];  % data structure containing protein abundance information (not used here)
arrayData = data_struct;  % data structure with gene (RNA) abundance information
metabolomicsData = [];  % list of metabolite names if metabolomic data is available
removeGenes = true;  % (default) remove lowly/non-expressed genes from the extracted GEM
taskFile = [];  % we already loaded the task file, so this input is not required
useScoresForTasks = true;  % (default) use expression data to decide which reactions to keep
printReport = true;  % (default) print status/completion report to screen
taskStructure = essentialTasks;  % metabolic task structure (used instead "taskFile")
params.TimeLimit = 5000;  % additional optimization parameters for the INIT algorithm
paramsFT = [];  % additional optimization parameters for the fit-tasks algorithm
%%
for i = 2:4
    tissue = char(data.Properties.VariableNames(i));
    disp(tissue);
    model = getINITModel2(refModel, tissue, celltype, hpaData, arrayData, metabolomicsData, removeGenes, taskFile, useScoresForTasks, printReport, taskStructure, params, paramsFT);
    model.id = tissue;
    model = simplifyModel(model);
    model.b = repelem(0,length(model.b))';
    %Curation Preparation
    media=readtable('Trial_HAM_HumanGem1.14_csv.csv');
    metList=table2array(media(:,8));
    lb=table2array(media(:,9));
    % model=simplifyModel(ihuman)
    exc=model.rxns(findExcRxns(model));
    mediacomps=exc(ismember(exc,findRxnsFromMets(model,metList)));
    %Constrain media by HAM media
    model=changeRxnBounds(model,exc,0,'l');
    model=changeRxnBounds(model,mediacomps,lb,'l');
    writeCbModel(model, 'fileName' , tissue , 'format','mat');
    pause(900);
end