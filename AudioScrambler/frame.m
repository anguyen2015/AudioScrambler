function [Y,winIndex] = frame(X,W,H)
% Y = frame(X,W,H)

% Length of the Audio
lx = length(X); 
% Approx frame height of the wave approxmated up
nh = 1+ceil((length(X)-W)/H);
% Sets a 1 x N based matrix based on the calculation
Xp = [X(:)',zeros(1, (W+(nh-1)*H)-lx)];

% Constructs an index based on the width and height of the frame 
winIndex = repmat(H*[0:(nh-1)],W,1)+repmat([1:W]',1,nh);

%Sorts the columns based on the generated index
Y = Xp(winIndex);