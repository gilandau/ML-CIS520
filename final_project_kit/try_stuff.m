addpath('./libsvm');
[u, s, v] = svds(X_train_bag, 100);

[itrfin] = multisvm( u(1:12000, :),Y_train(1:12000),u(12000:end, :) );
performance_measure(Y_train(12000:end), itrfin);