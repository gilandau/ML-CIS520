function [Y_hat] = predict_labels(X_test_bag, test_raw)


% Inputs:   X_test_bag     nx10000 bag of words features
%           test_raw      nx1 cells containing all the raw tweets in text


% Outputs:  Y_hat           nx1 predicted labels (1 for joy, 2 for sadness, 3 for surprise, 4 for anger, 5 for fear)
    %% Naive Bayes on bag of words
    
    load('model_nb.mat');
%     [~ ,pr1ob_nb, ~] = predict(model_nb, X_test_bag);
    [~ ,prob_nb, ~] = predict(model_nb, [X_test_bag, punctuation(X_test_bag)]);
    
    %% length of tweets + multinomial logistic regression
    
    
    %% liblinear logreg
    addpath('./liblinear');
    
     load('model_lr.mat');
    [~, ~, prob_lr] = predict(ones(size(X_test_bag, 1), 1), [double(logical(X_test_bag)), sparse(ones(size(X_test_bag, 1), 1))], model_lr, '-b 1');
    
    % somehow we have to switch positions because they were shuffled, no
    % need boy
%     prob_lr(:,[2,5]) = prob_lr(:,[5,2]);
    
    %% liblinear linear
    load('model_lin.mat');
    [alpha, ~, ~] = predict(zeros(size(X_test_bag, 1), 1), X_test_bag, model_lin);
    prob_lin = toCategorical(alpha);
    
    %% ensamble
    prob_total = 0.4*prob_nb + 0.6*prob_lr + 0*prob_lin;
    
    %% probability to class
    costs = [0 3 1 2 3; 4 0 2 3 2; 1 2 0 2 1; 2 1 2 0 2; 2 2 2 1 0];
    [~, Y_hat] = min(prob_total*costs, [], 2);
     
end