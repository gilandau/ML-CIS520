%  what they run
clear;
load('train.mat');
[Y_hat] = predict_labels(X_train_bag, train_raw);
disp(performance_measure(Y_hat, Y_train));
