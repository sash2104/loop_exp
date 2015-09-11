function kalman(file, N)
%infile = file;
infile = strcat(file, '.sal.feat');
outfile = strcat(file, '.kal.feat');
fid = fopen(infile, 'r');
fid2  =fopen(outfile, 'w');
Data = fscanf(fid, '%d %f %f', [3, inf]);
position = [Data(2,1:N);Data(3,1:N)];
estPt = ObjTrack(position);
fprintf(fid2, '%f %f %f %f\n', Data(2,N+1), Data(3,N+1), estPt(1), estPt(2));
clear all;
exit;
end


