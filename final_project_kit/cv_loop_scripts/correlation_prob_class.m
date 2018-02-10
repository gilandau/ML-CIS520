
[prob_lr, prob_nb, prob_lin] = train_predict(X_prop, Y_prop, X_test_prop);

    % see if there is a correlation between largest probability and correct
    % classification
    prob_lr = zeros(size(prob_lr));
    largest_prob = zeros(size(Y_test_prop));
    for iter=1:size(Y_test_prop, 1)
        [largest_prob(iter), ~] = max(prob_nb(iter,:));
    end
    
    
%     prob_estimates_total = prob_lr/2 + prob_nb/3 + prob_lin/4;
    Y_hat = probability_to_class(prob_nb);
    err = performance_measure(Y_hat, Y_test_prop);

%     fun = @(x)performance_measure(probability_to_class(prob_nb*x(1) + prob_lr * x(2) + prob_lin * x(3)), Y_test_prop);
%     best_weights = fminsearchbnd(fun, [1, .5, .5], [1, 0, 0], [1, 1, 1]);
%     best_weight_vec(N,:) = best_weights;
%     disp(best_weights);
%     prob_estimates_total = prob_nb*best_weights(1) + prob_lr * best_weights(2) + prob_lin * best_weights(3);
%     Y_hat = probability_to_class(prob_estimates_total);
%     err = performance_measure(Y_hat, Y_test_prop);
%     0.9336
%     plotting histogram of highest probability
    [No,edges] = histcounts(largest_prob(Y_hat==Y_test_prop));
    B=mean([edges(1:end-1);edges(2:end)]);
    plot(B, No, 'g');
    hold on 
    [No,edges] = histcounts(largest_prob(Y_hat~=Y_test_prop));
    B=mean([edges(1:end-1);edges(2:end)]);
    plot(B, No, 'r');
    hold on 
   