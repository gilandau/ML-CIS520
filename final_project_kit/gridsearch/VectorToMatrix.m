function [ OutputMatrix ] = VectorToMatrix ( SingleVector, Dimensions)
%% VectorToMatrix
%
%   This function is part of the Gridsearch main function.
%   It transforms the input vector into matrix of specific dimensions.
%

%% Reconstruction
%
%   This part reconstructs the input vector to a matrix with specific
%   dimensions.

    OutputMatrix = reshape( SingleVector, Dimensions );


end
