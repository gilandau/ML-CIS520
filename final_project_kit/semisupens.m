function [ biggerNB,newxtrain,newytrain ] = semisupens( X_test )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

addpath('./liblinear')
skip = 0;
load('train.mat');
newxtrain = X_train_bag;
newytrain = Y_train;
costs = [0 3 1 2 3; 4 0 2 3 2; 1 2 0 2 1; 2 1 2 0 2; 2 2 2 1 0];

g = 1;

for q = 1:75
    biggerNB = fitcnb(newxtrain,newytrain,'Distribution','mn');
    [~ ,probnb, ~] = predict(biggerNB, X_test);
    
    
%     model_lr = train(newytrain, double(logical(newxtrain)), '-s 0 -q 1');
%     [~, ~, problr] = predict(zeros(size(X_test_prop, 2)), double(logical(X_test_prop)), model_lr, '-b 1');
    
    prob_total = probnb %  + problr*0.4;
    [~, Y_hat] = min(prob_total*costs, [], 2);
    %disp(loss(biggerNB,newxtrain,newytrain));
    for i = 1:9098
        for j = 1:5
%             if (probtotal(i,j) > 1.60 && ~max(ismember(skip(:),i))
            if max > 0.80
                newxtrain = vertcat(newxtrain,X_test(i,:));
                [~, Y_hat] = min(probtotal(i,:)*costs, [], 2);
                newytrain = vertcat(newytrain,Y_hat);
                skip = horzcat(skip,i);
                g = g+1;
                break;
            end
        end
    end  
end




end

