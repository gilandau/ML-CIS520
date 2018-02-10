function [prob_nb, prob_lr] = train_predict(X_train, Y_train, X_test)


% Inputs:   X_test_bag     nx10000 bag of words features
%           test_raw      nx1 cells containing all the raw tweets in text


% Outputs:  Y_hat           nx1 predicted labels (1 for joy, 2 for sadness, 3 for surprise, 4 for anger, 5 for fear)
    
    %% Naive Bayes on bag of words
    model_nb = fitcnb(X_train, Y_train, 'distribution', 'mn');
    [~ ,prob_nb, ~] = predict(model_nb, X_test);
    

    %% liblinear logreg
    addpath('./liblinear');
    model_logreg = train(Y_train, double(logical(X_train)), '-s 0 -q 1');
    
    % model_logreg = train(Y_train, X_train_bag, '-s 0');
    [~, ~, prob_lr] = predict(zeros(size(X_test, 1), 1), double(logical(X_test)), model_logreg, '-b 1');

    %% liblinear irgendwas 
%     addpath('./liblinear');
%     model_linear = train(Y_train, X_train, '-s 1 -q 1');
%     [alpha, ~, ~] = predict(zeros(size(X_test, 1), 1), X_test, model_linear, '-b 1');
%     prob_lin = toCategorical(alpha);
    
    %% libsvm onevsall approach: https://stackoverflow.com/questions/9041753/multi-class-classification-in-libsvm
    
%     svmStruct = svmtrain(X_train, Y_train);
%     [label,score] = svmpredict(zeros(size(X_test, 1)), X_test, svmStruct);

end