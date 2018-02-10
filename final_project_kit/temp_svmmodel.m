%%%TESTING
clear;
load("train.mat");
addpath('./libsvm');
X = X_train_bag;
Y = Y_train;
% [X_most_freq] = mostusedwords(X_train_bag);
K = 10;
err_vec = zeros(K,1);
joy= X(Y==1, :);
sadness = X(Y==2, :);
surprise = X(Y==3, :);
anger = X(Y==4, :);
fear = X(Y==5, :);
cv_index_all = crossvalind('KFold', size(X,1), K);
cv_index_joy = crossvalind('KFold', size(joy,1), K);
cv_index_sadness = crossvalind('KFold', size(sadness,1), K);
cv_index_surprise = crossvalind('KFold', size(surprise,1), K);
cv_index_anger = crossvalind('KFold', size(anger,1), K);
cv_index_fear = crossvalind('KFold', size(fear,1), K);

N = 1;
[~, ~, ~, ~, X_prop, Y_prop, X_test_prop, Y_test_prop] = CV(X, Y, N, cv_index_all, cv_index_joy, cv_index_sadness, cv_index_fear, cv_index_surprise, cv_index_anger);


svmmodel = svmtrain(Y_prop, X_prop, '-t 1 -b 1');
[predicted_label, accuracy, prob_estimates] = svmpredict(full(Y_test_prop), X_test_prop, svmmodel, '-b 1');
Y_hat = probability_to_class(prob_estimates);
err = performance_measure(Y_hat, full(Y_test_prop));