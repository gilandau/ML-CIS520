function [predictions] = toCategorical(arr)
% input: mx1 vector containing 1 to 5
% output: mx5 matrix containing 0 and 1

predictions = zeros(size(arr, 1), 5);
for i = 1:size(arr, 1)
    predictions(i, arr(i)) = 1;
end
