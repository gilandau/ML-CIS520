function [ SingleVector, Dimensions ] = MatrixToVector ( InputMatrix )
%% MatrixToVector
%
%   This function is part of the Gridsearch main function.
%   It transforms the input matrix into single vector.
%

%% Find the Matrix sizes.
%   
%   This part finds and stores the dimentions of the input matrix for
%   future reconstruction.

 [ Dimensions ] = size ( InputMatrix );

%% Reshape the Matrix.
%
%   This part reshapes the input matrix to vector.
 
 SingleVector = squeeze ( InputMatrix(:) );
 
end