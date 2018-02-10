function [err] = loss_function(prob_total, y_hat)
    addpath('./helper');
    y_hat_cat = toCategorical(y_hat);
    err = sum(sum(abs(y_hat_cat - prob_total))); % maybe use frobenius
end
