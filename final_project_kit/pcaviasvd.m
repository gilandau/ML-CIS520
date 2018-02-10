function [V, xbar] = pcaviasvd(xtrain)

%xtrain = topvocab(xtrain);
%z = zeros(18092,1500);
xbar = mean(xtrain);
Xc = xtrain - xbar;
[U, S, V] = svds(Xc,100);
%z = Xc*V;



%[score_train, numpc] = pca_getpc(U*S*V');
%z = score_train(:,1:numpc);




end

