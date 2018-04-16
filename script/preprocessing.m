mkdir('Altered')
currentFolder = pwd;
dataPath = fullfile(currentFolder,'data');
% input 
NGdataPath = fullfile(dataPath,'Original','NG');
PASSdataPath = fullfile(dataPath,'Original','PASS');
% output
NGOutputPath = fullfile(dataPath,'Altered','NGOut');
PASSOutputPath = fullfile(dataPath, 'Altered','PASSOut');

% resize images
NGs = dir(NGdataPath);
for i=3:numel(NGs)
   name =  NGs(i).name;
   img = imread(fullfile(NGdataPath,name));
   if ~isequal(size(img), [70,70])
       temp_img = imresize(img, [70,70]);
   else
       temp_img = img;
   end
   imwrite(temp_img, fullfile(NGOutputPath, name));
end

PASSs =  dir(PASSdataPath);
for i=3:numel(PASSs)
   name =  PASSs(i).name;
   img = imread(fullfile(PASSdataPath,name));
   if ~isequal(size(img), [70,70])
       temp_img = imresize(img, [70,70]);
   else
       temp_img = img;
   end
   imwrite(temp_img, fullfile(PASSOutputPath, name));
    
end
