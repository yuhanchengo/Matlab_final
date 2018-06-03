
function split_test()
% split out test files
    ngs = dir('data/Altered/NG');
    passes = dir('data/Altered/PASS');
    
%     tf_ng = randperm(numel(ngs)) > (0.15*numel(ngs));
%     tf_ps = randperm(numel(passes)) > (0.15*numel(passes));
    mov_indx = randperm(numel(ngs), floor(numel(ngs)*0.15));
    mov_indx_ps = randperm(numel(passes), floor(numel(passes)*0.15));
    
    if ~exist('data/test','dir')
        mkdir('data/test');
        mkdir('data/test/NG');
    end
    if ~exist('data/test/PASS','dir')
        mkdir('data/test/PASS');
    end

    for i=1:numel(mov_indx)
        movefile(fullfile('data/Altered/NG/',ngs(mov_indx(i)).name), 'data/test/NG/');
    end

    for i=1:numel(mov_indx_ps)
        movefile(fullfile('data/Altered/PASS/', passes(mov_indx_ps(i)).name), 'data/test/PASS/');
    end
end
