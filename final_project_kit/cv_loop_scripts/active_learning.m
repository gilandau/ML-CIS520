
model_nb = fitcnb(X_prop, Y_prop, 'distribution', 'mn');
[~ ,prob_nb, ~] = predict(model_nb, X_test_prop);

model_lr = train(Y_prop, double(logical(X_prop)), '-s 0 -q 1');
[~, ~, prob_lr] = predict(Y_test_prop, double(logical(X_test_prop)), model_lr, '-b 1');

prob_total = (prob_lr + prob_nb)/2;

[largest_prob, Y_hat] = max(prob_total, [], 2);
% 
%     [No,edges] = histcounts(largest_prob(Y_hat==Y_test_prop));
%     B=mean([edges(1:end-1);edges(2:end)]);
%     plot(B, No, 'g');
%     hold on 
%     [No,edges] = histcounts(largest_prob(Y_hat~=Y_test_prop));
%     B=mean([edges(1:end-1);edges(2:end)]);
%     plot(B, No, 'r');
%     hold on 
    
[No1,edges1] = histcounts(largest_prob(Y_hat==Y_test_prop), (0:20)/20);
[No2,edges2] = histcounts(largest_prob(Y_hat~=Y_test_prop), (0:20)/20);

line = No1./(No1+No2);
B=mean([edges1(1:end-1);edges1(2:end)]);
plot(B, line);
hold on 

err = 0;