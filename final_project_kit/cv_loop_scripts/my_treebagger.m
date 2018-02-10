%  we can incorporate costs in treebagger
% [U,S,V] = svds(X_train_bag, 200);

% [V, xbar] = pcaviasvd(X_train_bag);
% costs = [0 3 1 2 3; 4 0 2 3 2; 1 2 0 2 1; 2 1 2 0 2; 2 2 2 1 0];
load('V');
load('xbar');
new_train = (X_prop)*V;
% mdl = TreeBagger(50, new_train, Y_prop);
%, 'Cost', costs\
new_val = (X_test_prop) * V; 

    model_lr = train(Y_prop, [sparse(new_train), sparse(ones(size(Y_prop)))], '-s 0 -q 1');
    [~, ~, prob_lr] = predict(Y_test_prop, [sparse(new_val), sparse(ones(size(Y_test_prop)))], model_lr, '-b 1');
%     prob_lr(:,[2,5]) = prob_lr(:,[5,2]);



% [~,prob_rf,~] = predict(mdl, new_val);


Y_hat = probability_to_class(prob_lr);
err = performance_measure(Y_test_prop, Y_hat);


disp(k_means(new_train,Y_prop,new_val,Y_test_prop, 50));

xbar = mean(X_train_bag);
X_prop = X_prop - xbar;
X_prop = X_prop - xbar;