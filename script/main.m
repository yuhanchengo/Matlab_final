% % load and explore data
currentFolder = pwd;
dataPath = fullfile(currentFolder,'data','Altered');
JointData =  imageDatastore(dataPath, 'IncludeSubfolders', true, 'LabelSource','foldernames');
testDataPath = fullfile(currentFolder,'data','test');
Test  = imageDatastore(testDataPath, 'IncludeSubfolders', true, 'LabelSource','foldernames');

% % NG:8244 PASS:9016 
labelCount = countEachLabel(JointData);
testLabelCount = countEachLabel(Test);
% % split datastore to 85/15
[Training, Validation] = splitEachLabel(JointData,0.85);

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
% net = trainNetwork(Training, layers, options);
% test model on test data
% test_model(net, Test);

predict = test_one(net, 'data/test/PASS/1333420170808091047120L2.bmp');
disp(predict);

function accuracy = test_model(net, Test)
% % test model
    predict = classify(net, Test);
    answer  = Test.Labels;
    accuracy = sum(predict==answer)/numel(answer) % numel: # array elements
end

function predict = test_one(net, img)
% predict one image
% img = img path and name ex: 'data/test/PASS/1333420170808091047120L2.bmp'
    currentFolder = pwd;
    img = imageDatastore(fullfile(currentFolder,img));
    predict = classify(net, img);
end
