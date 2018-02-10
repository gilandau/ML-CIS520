% log reg 
addpath('./libsvm');
addpath('./liblinear');
addpath('./data');
addpath('./models');
addpath('./helper');
addpath('./cv_loop_scripts');

load('train.mat');
new_XY = [X_train_bag, Y_train];
new_XY = sortrows(new_XY, 10001);
X_train_bag = new_XY(:, 1:10000);
Y_train = sortrows(Y_train);

% model_lr = train(Y_train, [double(logical(X_train_bag)), sparse(ones(size(Y_train)))], '-s 0 -q 1');
% save('model_lr', 'model_lr');


model_lin = train(Y_train, [X_train_bag, sparse(ones(size(Y_train)))], '-s 1 -q 1');
save('model_lin', 'model_lin');