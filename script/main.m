% % load and explore data
currentFolder = pwd;
dataPath = fullfile(currentFolder,'data','Altered');
JointData =  imageDatastore(dataPath, 'IncludeSubfolders', true, 'LabelSource','foldernames');

% % NG:8244 PASS:9016 
labelCount = countEachLabel(JointData);

% % split datastore to 70/30
[Training, Validation] = splitEachLabel(JointData,0.7);

% % Define Network structure
layers =  [
    imageInputLayer([70 70 3])
    convolution2dLayer(5, 7, 'BiasLearnRateFactor', 2)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride', 2)
    
    convolution2dLayer(5, 14, 'BiasLearnRateFactor', 2)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride', 2)
    
    convolution2dLayer(5, 28, 'BiasLearnRateFactor', 2)
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(2) % binary classification
    softmaxLayer
    classificationLayer];

% % specify for training
options =  trainingOptions('sgdm', ...
    'MaxEpochs', 4,  ...
    'ValidationData', Validation, ...
    'ValidationFrequency', 30, ...
    'Verbose', false, ...
    'Plots', 'training-progress');

% % start training with prepared training data
net = trainNetwork(Training, layers, options);

% % test model
predict = classify(net, Validation);
answer  = Validation.Labels;
accuracy = sum(predict==answer)/numel(answer) % numel: # array elements

