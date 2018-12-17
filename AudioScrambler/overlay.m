function [X,opix] = overlay(Y,H)
% Overlay columns of Y, with offset of H.

% Computates size and length of the modulated clip
[W,nw] = size(Y);

% Computates the total length of the audio clip will take
% when pasted into the frame
lenx = (W + (nw-1)*H);

% The approach is to build an index matrix, where each row pulls 
% in successive, nonoverlapping windows from the original data.
% This matrix then has as many rows as needed to get all the
% overlapping windows. 

% The number of windows that overlap at each point
% = the number of rows that are needed for the matrix.
ovf = ceil(W/H);

% How many windows will there be in each row?
nwonf = ceil(nw/ovf);

% Unravel the matrix Y, then add a zero on the end.
Ywz = [Y(:)',0];
% Index for the last part of the audio clip
leny = length(Ywz);

% Create one row of the final index
% Matrix that pulls out every ovf'th window from the original
% Matrix in its unravelled form. 
% If any holes exist in the waveform, writes 0 to the form.
opix = reshape(repmat([[1:W],leny*ones(1,ovf*H - W)]', 1, nwonf) ...
               + repmat(ovf*W*[0:(nwonf-1)], ovf*H, 1), ...
               1, ovf*H*nwonf);

% Fades out the ending of the audio
opix = [opix,leny*ones(1,lenx-length(opix))];
lopix = length(opix);

% Add in the following rows, which are offset by H points, and with
% indices that are shifted
for i = 2:ovf
  opix = [opix;[leny*ones(1,(i-1)*H),W+opix(1,1:(lopix-(i-1)*H))]];
end

% Set end points of the frames to 0
opix(opix > leny) = leny;

% Compile the new shuffled waveform
X = sum(Ywz(opix))';