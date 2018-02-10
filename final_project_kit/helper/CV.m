function [X_all, Y_all, X_test_all, Y_test_all,X_prop, Y_prop, X_test_prop, Y_test_prop] = CV(X, Y, N, cv_index_all, cv_index_joy, cv_index_sadness, cv_index_fear, cv_index_surprise, cv_index_anger)
    joy= X(Y==1, :);
    sadness = X(Y==2, :);
    surprise = X(Y==3, :);
    anger = X(Y==4, :);
    fear = X(Y==5, :);

    X_all = X(cv_index_all ~= N, :);
    Y_all = Y(cv_index_all ~= N, :);

    X_test_all =  X(cv_index_all == N, :);
    Y_test_all = Y(cv_index_all == N, :);

    X_J = joy(cv_index_joy ~= N, :);
    Y_J = ones(size(X_J,1),1);

    X_test_J =  joy(cv_index_joy == N, :);
    Y_test_J = ones(size(X_test_J,1),1);

    X_S = sadness(cv_index_sadness ~= N, :);
    Y_S(1:size(X_S,1),1) = 2;

    X_test_S = sadness(cv_index_sadness == N, :);
    Y_test_S(1:size(X_test_S,1),1) = 2;

    X_SUR = surprise(cv_index_surprise ~= N, :);
    Y_SUR(1:size(X_SUR,1),1) = 3;

    X_test_SUR = surprise(cv_index_surprise == N, :);
    Y_test_SUR(1:size(X_test_SUR,1),1) = 3;

    X_A = anger(cv_index_anger ~= N, :);
    Y_A(1:size(X_A,1),1) = 4;

    X_test_A = anger(cv_index_anger == N, :);
    Y_test_A(1:size(X_test_A,1),1) = 4;

    X_F = fear(cv_index_fear ~= N, :);
    Y_F(1:size(X_F,1),1) = 5;

    X_test_F = fear(cv_index_fear == N, :);
    Y_test_F(1:size(X_test_F,1),1) = 5;

    X_prop = [X_J; X_S; X_SUR; X_A; X_F];
    Y_prop = [Y_J; Y_S; Y_SUR; Y_A; Y_F];

    X_test_prop =  [X_test_J; X_test_S; X_test_SUR; X_test_A; X_test_F];
    Y_test_prop = [Y_test_J; Y_test_S; Y_test_SUR; Y_test_A; Y_test_F];
    
    % shuffle X_prop, Y_prop, X_test_prop, Y_test_prop
%     temp2 = [X_prop, Y_prop];
%     temp2 = temp2(randperm(end),:);
%     Y_prop = full(temp2(:,end));
%     X_prop = temp2(:,1:end-1);

%     temp = [X_prop, Y_prop];
%     temp = temp(randperm(end),:);
%     Y_prop = full(temp(:,end));
%     X_prop = temp(:,1:end-1);
%     
%     temp = [X_test_prop, Y_test_prop];
%     temp = temp(randperm(end),:);
%     Y_test_prop = full(temp(:,end));
%     X_test_prop = temp(:,1:end-1);
end
