function Y = shuffle(X,W,R)
% Causes W to round to an even number 
W = W + rem(W,2);
% Sets the Overlapping Window Offset /2 50%
H = W/2;

% Creates an audio sample matrix(single column) and multiples it
% with a matrix representing the frame generated from frame().
Yw = diag(hanning(W)')*frame(X,W,H);

% Calculates how the sample window will be scrambled.
% A statistical permutation is used to ensure the audio stays within a
% range that will allow the audio to be recognizeable. 
% Aruguements are sample size of the window, and a standard deviation
rpx = audioperm(size(Yw,2),R/H);

% Matrix Reordering : Keeps the Row Index. rpx random sorts the matrix
% column based on the permutation
Yw = Yw(:,rpx);

% Overlay the modified window over the original file
Y = overlay(Yw,H);
% Check to see if the length of the modified audio has not changed
% in comparison to the original.
Y(length(X)+1) = 0;
Y = Y(1:length(X));