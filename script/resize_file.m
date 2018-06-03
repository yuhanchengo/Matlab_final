function resize_file()
    currentFolder = pwd;
    if ~exist('data/Altered','dir')
        % make directories for new folders
        mkdir('data/Altered');
        mkdir('data/Altered/NG');
        mkdir('data/Altered/PASS');

        dataPath = fullfile(currentFolder,'data');
        % input 
        NGdataPath = fullfile(dataPath,'Original','NG');
        PASSdataPath = fullfile(dataPath,'Original','PASS');
        % output
        NGOutputPath = fullfile(dataPath,'Altered','NG');
        PASSOutputPath = fullfile(dataPath, 'Altered','PASS');

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
    end
end
