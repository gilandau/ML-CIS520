% [~, ~, ~, ~, X_prop, Y_prop, X_test_prop, Y_test_prop] = CV(X, Y, N, cv_index_all, cv_index_joy, cv_index_sadness, cv_index_fear, cv_index_surprise, cv_index_anger);

[prob_lr, prob_nb, prob_lin] = train_predict(X_prop, Y_prop, X_test_prop);
prob_estimates_total = prob_lr/3 + prob_nb/3 + prob_lin/3;
err2 = loss_function(prob_estimates_total, Y_test_prop);

fun = @(x)loss_function(probability_to_class(prob_nb*x(1) + prob_lr * x(2) + prob_lin * x(3)), Y_test_prop);
best_weights = fminsearchbnd(fun, [1, .5, .5], [1, 0, 0], [1, 1, 1]);

best_weight_vec(N,:) = best_weights;
disp(best_weights);

prob_estimates_total = prob_nb*best_weights(1) + prob_lr * best_weights(2) + prob_lin * best_weights(3);
Y_hat = probability_to_class(prob_estimates_total);
err = performance_measure(Y_hat, Y_test_prop);