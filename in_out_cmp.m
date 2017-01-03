% function diff=cmpdata(in,out)
fileName = 'videos/*.mat';
files = dir(fullfile(pwd,fileName));
filenum=size(files,1);
qualities=[18 23 28 33 38 43];
for q=1:6
    for id = 1:1%filenum
        f_name=files(id,1).name;    
        in=['2016/input_data_',num2str(qualities(q)),'_',f_name];
        out=['2016/output_data_',num2str(qualities(q)),'_',f_name];
        load(in,'embedded_data');
        load(out,'extracted_data');
        disp([in,out]);
        k=0;
        n=length(embedded_data);
        m=length(extracted_data);
        N=min(n,m);
        for i=1:N
            if ~strcmp(embedded_data(i),extracted_data(i))
                k=k+1;
                disp(['Wrong at location ',num2str(i),'. Input(',num2str(i),') is ',embedded_data(i),', output(',num2str(i),') is ',extracted_data(i)]);
            end
        end
        disp(k);
    end
end
