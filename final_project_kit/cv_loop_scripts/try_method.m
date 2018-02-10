   
    addpath('./liblinear');
  
%     model_lr = train(Y_prop, [double(logical(X_prop)), sparse(ones(size(Y_prop)))], '-s 0 -q 1');
%     load('model_lr.mat');
%     [~, ~, prob_lr] = predict(Y_test_prop, [double(logical(X_test_prop)), sparse(ones(size(Y_test_prop)))], model_lr, '-b 1');
%     prob_lr(:,[2,5]) = prob_lr(:,[5,2]);
    

    
%     model_nb = fitcnb([X_prop, punctuation(X_prop)], Y_prop, 'distribution', 'mn');
%     [~ ,prob_nb, ~] = predict(model_nb, [X_test_prop, punctuation(X_test_prop)]);
    
%     
%     model_nb = fitcnb([X_prop, punctuation(X_prop)], Y_prop, 'distribution', 'mn');
%     save('model_nb', 'model_nb');
%     load('model_nb.mat')
%     [~ ,prob_nb, ~] = predict(model_nb, [X_test_prop, punctuation(X_test_prop)]); 


%     model_lin = train(Y_prop, [X_prop, sparse(ones(size(Y_prop)))], '-s 1 -q 1');
    load('model_lin.mat')
    Y_hat = predict(Y_test_prop, [X_test_prop, sparse(ones(size(Y_test_prop)))], model_lin);
    prob_lin = toCategorical(Y_hat);
    
    Y_hat = probability_to_class(prob_lin);
    err = performance_measure(Y_hat, Y_test_prop);
  