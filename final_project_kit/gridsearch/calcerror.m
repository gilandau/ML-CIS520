function [ error ] = calcerror ( validation, validationtarget, machine )
%% calcerror
%
%   This function if part of the Gridsearch main function.
%   It calculates the error of the validation set targets and the output of
%   the trained SVM predictor.
%

%% svmpredic
%
%   This part predicts the outputs of the SVMs given differnt inputs.
%   Output is stored in predict variable. 
%

[ predict ] = svmpredict ( validationtarget, validation, machine );

%% Error calculate
%
%   This part calculates the Mean absolute error of the difference between
%   Targets and predictet value.

error = mae ( validationtarget - predict );

end