function [ matrixErr ] = Gridsearch ( Train, TrainTarget, Validation, ValidationTarget, vectorC, vectorG )
%% Gridsearch
%
%   Perform gridsearch for LibSvm support vector library. 
%   This function is suitable for evaluating grid search using two input
%   vectors. After calculation error matrix is returned. The method is
%   simple grid search for parameters C - cost and G - gamma. 
%   In future releases more parameters will be added.
%   
%
%   Syntax: [ matrixErr ] = Gridsearch ( train, traintarget, validation, ...
%                                      validationtarget, vectorC, vectorG )
%
%
%       Train: 
%           Input train set of parameters.
%
%       TrainTarget:
%           Input train target set.
%
%       Validation:
%           Input validation set of parameters.
%
%       ValidationTargets:
%           Input validation target set.
%
%       vectorC:
%           Input vector for Cost parameter. Typically it is consisted of
%           exponentially growing values.
%
%       vectorG:
%           Input vector for Gamma parameter. Typically it is consisted of
%           exponentially growing values.
%
%       matrixErr:
%           Output matrix consisting the calculated error values of the
%           validation set with different C and G parameters.
%
%% Cellarray
%
%   This part creates array of cells containing the parameters string
%   needed by LibSvm. 
addpath('./libsvm');
cells = cellarray ( vectorC, vectorG );

%% MatrixToVector
%
%   This part reshapes the cell array in single vector. This is suitable
%   for optimisation of the speed of the Parfor loop.

[ SingleVector, Dimensions ] = MatrixToVector ( cells );

%% Temp err vector
%
%   This part creates temporary vector containing the values of the
%   different parameters errors.
%
err = ones ( 1, length ( SingleVector ) );

%% Main Parallel loop
%
%   This part evaluates parallel loop for each sequence of parameters.
%   
    parfor n = 1 : length ( SingleVector )  %Start Parfor loop.

        machine = svmtrain ( TrainTarget, Train, char ( SingleVector ( n ) ) ); 
                                            %Train SVM with current parameters.
        
        err ( n ) = calcerror ( Validation, ValidationTarget, machine );
                                            %Calculate the error of thes
                                            %sequence of parameters.
                                            
    end                                     %End Parfor loop.


%% Reconstruct
%
%   This part reconstructs the error matrix to original shape according the
%   original grid of parameters.
%   

matrixErr = VectorToMatrix ( err, Dimensions );

%% Save
%
%   This part saves the error matrix and the parameters of the grid search.

save ( 'matrixErr.mat', 'matrixErr', 'vectorC', 'vectorG' );

end