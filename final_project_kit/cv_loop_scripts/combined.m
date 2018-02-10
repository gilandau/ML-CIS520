    addpath('./liblinear');
    
    model_lr = train(Y_prop, [double(logical(X_prop)), sparse(ones(size(Y_prop)))], '-s 0 -q 1');
    [~, ~, prob_lr] = predict(Y_test_prop, [double(logical(X_test_prop)), sparse(ones(size(Y_test_prop)))], model_lr, '-b 1');
    
    model_nb = fitcnb([X_prop, punctuation(X_prop)], Y_prop, 'distribution', 'mn');
    [~ ,prob_nb, ~] = predict(model_nb, [X_test_prop, punctuation(X_test_prop)]);    
    
%     model_lin = train(Y_prop, [double(logical(X_prop)), sparse(ones(size(Y_prop)))], '-s 1 -q 1');
%     Y_lin = predict(Y_test_prop, [double(logical(X_test_prop)), sparse(ones(size(Y_test_prop)))], model_lr);
%     prob_lin = toCategorical(Y_lin);
    
%     B_final= mnrfit([prob_nb, prob_lr, prob_lin], Y_test_prop);
%     [~, ~, total] = predict(Y_test_prop, sparse([prob_nb, prob_lr, prob_lin]), model_final_lr);
%     disp(performance_measure(probability_to_class(total), Y_test_prop));
    
    prob_total = 0.4*prob_nb + 0.6*prob_lr; % + 0*prob_lin;
%     fun = @(x)performance_measure(probability_to_class(prob_nb*x(1) + prob_lr * x(2) + prob_lin * x(3)), Y_test_prop);
%     best_w = fminsearchbnd(fun, [.5, .5, .5], [0, 0, 0], [1, 1, 1]);
%     perf = performance_measure(probability_to_class(prob_nb*best_w(1) + prob_lr * best_w(2) + prob_lr * best_w(3)), Y_test_prop);
%     best_weight = best_w/sum(best_w);
%     disp(perf);
%     res_vec = zeros(11, 3);
%     for i=(0:10)/10
%         best_w = (fminsearchbnd(fun, [i, (1-i)], [-1, -1], [1, 1]))/sum(fminsearchbnd(fun, [i, (1-i)], [-1, -1], [1, 1]));
% %         disp(best_weights);
%   
%         perf = performance_measure(probability_to_class(prob_nb*best_w(1) + prob_lr * best_w(2)), Y_test_prop);
% %         disp(num2str(perf));
%         res_vec(i*10+1, 3) = perf;
%         res_vec(i*10+1, 1:2) = best_w;
% %         disp(['with different weights: ', num2str(performance_measure(probability_to_class(prob_nb*i + prob_lr * (1-i)), Y_test_prop))]);
%     end
%     [a, idx] = min(res_vec(:, 3));
%     best_weight = res_vec(idx, 1:2);
    
    
    
%     fun = @(x)performance_measure(probability_to_class(prob_nb*x(1) + prob_lr * x(2)), Y_test_prop);
%     best_weights = fminsearchbnd(fun, [1, .5], [1, -1], [1, 1]);
%     
%     
%     disp(['with best weights: ', num2str(performance_measure(probability_to_class(prob_nb*best_weights(1) + prob_lr * best_weights(2)), Y_test_prop))]);
%     disp(best_weights);
%     best_weights = fminsearchbnd(fun, [1, 0], [1, -1], [1, 1]);
%     disp(['with best weights2: ', num2str(performance_measure(probability_to_class(prob_nb*best_weights(1) + prob_lr * best_weights(2)), Y_test_prop))]);
%     disp(best_weights);
    Y_hat = probability_to_class(prob_total);
    err = performance_measure(Y_hat, Y_test_prop);