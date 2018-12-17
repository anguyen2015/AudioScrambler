function I = audioperm(N,R)
% I = localperm(N,R)
%    I is a random permutation of the integers from 1:N.  
%    The displacement I(x) - x has a gaussian
%    distribution (normal distribution) with standard deviation R.

I = zeros(1,N) - 1;
D = round(R*randn(1,N));
remaining = ones(1,N);

% Assigns positions randomly within the distribution
for i = randperm(N)
  % Creates an postional offset
  ipos = i + D(i);
  % Find a position in the audio that has not been replaced
  % Replace it with the new position
  frem = find(remaining);
  [~,posix] = min(abs(frem - ipos));
  % Replacement Occurs
  pos = frem(posix);
  I(pos) = i;
  remaining(pos) = 0;
end