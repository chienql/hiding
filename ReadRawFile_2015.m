%% This function is designed to read and convert input data video stream,
% and write to video frame sequence 
% Input: raw_data is the original video file name
% Output: 
%       VideoSeq_Input: Video sequences by Height x Width x NumberOfVideoFrames
%       Frame_start   : Starting frame
%       Frame_end     : Ending frame 
% Example:  [VideoSeq,F_start,F_end]=ReadRawFile('akiyo.mat')

%% Begin function 
function [VideoSeq_Input,Frame_start,Frame_end]=ReadRawFile_2015(raw_data)
load(raw_data,'mov');
Height=144;
Width=176;
FrameRate=30;

%% Read Number of frames from Video input file.
Frames=size(mov);
Frame_start=Frames(1);
Frame_end=Frames(2);
FrameNo=(Frame_end-Frame_start)+1;

%% Read frames in movie (structure) and write to Input Video Sequences (VideoSeq_Input) 
VideoSeq_Input=zeros(Height,Width,FrameNo); %Starting with zero values 
writeObj=VideoWriter(['2016_Decoded_Videos/',raw_data '.avi'],'Uncompressed AVI'); %Write to writeObj
open(writeObj);
%Convert from mov.cdata to Video sequence
for i=Frame_start:Frame_end
I= .2989*mov(1,i).cdata(1:Height,1:Width,1)...
	+.5870*mov(1,i).cdata(1:Height,1:Width,2)...
	+.1140*mov(1,i).cdata(1:Height,1:Width,3);
VideoSeq_Input(:,:,i)=I; 
writeVideo(writeObj,I);
end

% Open new window and play video 
hf = figure;  
set(hf, 'position', [1000 500 Width Height])

% Play back the movie once at the video's frame rate.
movie(hf, mov, 1, FrameRate); 
