% run pca, k_means, EM, random forest, naive bayes (oh boy)
% how to work with different penaltys

%% load data
clear
%  load validation.mat
load train.mat
% load vocabulary.mat

% costs = [0 3 1 2 3; 4 0 2 3 2; 1 2 0 2 1; 2 1 2 0 2; 2 2 2 1 0];


%%  NB we probably should use additive smoothing xval!

% model_nb = fitcnb(X_train_bag, Y_train, 'distribution', 'mn');
% save('model_nb.mat','model_nb')
load('model_nb.mat')
[label,Posterior,Cost] = predict(model_nb, X_train_bag);
predictions = probability_to_class(Posterior);
measure = performance_measure(predictions, Y_train);


%% first try to implement CV
load train.mat

% permute training matrix, permute Y matrix the same hopefully
X_train_shuffled = X_train_bag(randperm(size(X_train_bag,1)),:);
% split into 5 equal parts
X_new = cell(1, 4);
Y_new = cell(1, 4);
for i = 1:4
    X_new{i} = X_train_bag(1+(i-1)*4523:i*4523, :);
    Y_new{i} = Y_train(1+(i-1)*4523:i*4523);
end

% train on 3, run on 4th. 
k = 4;
for iter = 1:k
    i = mod(iter:k-1+iter, k) + 1;
    X_train = [X_new{i(1)}; X_new{i(2)}; X_new{i(3)}];
    X_test  = X_new{4};
    Y_train = [Y_new{i(1)}; Y_new{i(2)}; Y_new{i(3)}];
    Y_test  = Y_new{4};
    
    [prob_nb, prob_lr] = train_predict(X_train, Y_train, X_test);
    
    % what are good weights?, maybe different performance measure using mx5
    % matrices
    fun = @(x)performance_measure(probability_to_class(prob_nb*x(1) + prob_lr * x(2)), Y_test);
    best_weights = fminsearchbnd(fun, [0.5, 0.5], [0, 0], [1, 1]);
    'best weights'
    disp(fminsearchbnd(fun, [1, 0], [0, 0], [1, 1]));
    disp(fminsearchbnd(fun, [0, 1], [0, 0], [1, 1]));
    disp(best_weights);
    disp(performance_measure(probability_to_class(prob_nb*best_weights(1) + prob_lr * best_weights(2)), Y_test))
    disp(performance_measure(probability_to_class(prob_nb), Y_test))

end


    %%
    w2 = (0:30)/10;
    errs = zeros(size(w2));
        
    for j=1:size(w2, 2)
        disp(j);
        errs(j) = performance_measure(probability_to_class(prob_nb + prob_lr * w2(j)), Y_test);
    end
    plot(w2, errs);
    hold on;


%% liblinear training, train some more models ma boy

addpath('./liblinear');
load('model_logreg.mat', 'model_logreg');

% model_logreg = train(Y_train, X_train_bag, '-s 0');
[predicted_label, accuracy, prob_estimates] = predict(Y_train, X_train_bag, model_logreg, '-b 1');

prob_estimates(:,[2,5]) = prob_estimates(:,[5,2]);
Y_hat = probability_to_class(prob_estimates);
err = performance_measure(Y_train, Y_hat);

%% 

X_train_new = X_train_bag(Y_train<=2, :);
Y_train_new = Y_train(Y_train<=2, :);
[U,T,mu] = pcasecon(X_train_bag,2);

%% length of tweet, multinomial logreg

tweet_length = sum(X_train_bag,2);
tweet_length = zeros(size(X_train_bag, 1), 1);
for i=1:size(X_train_bag, 1)
    tweet_length(i) = size(char(train_raw(i)), 2);
end


B = mnrfit(tweet_length,Y_train); %% svd + nb
pi_hat = mnrval(B,tweet_length);
output = probability_to_class(pi_hat);
% [~, output] = max(pi_hat, [], 2);
% output = ones(18092, 1)*5;
err = performance_measure(output, Y_train);
% random_guessing = performance_measure(randi([1 5],1,size(Y_train,1))', Y_train);
% disp(a);

%% length of tweet, 
tweet_length = sum(X_train_bag,2);




%%

for k=4:2:100
    [svd,S,V] = svdsecon(X_train_bag, k);
    disp(k)
%     [U,T,mu] = pcasecon(svd,20);
    U = svd;
    Mdl = fitcnb(U+1e-10,Y_train);
    [label,Posterior,Cost] = predict(Mdl,U+1e-10);
    output = probability_to_class(Posterior);
    a = performance_measure(output, Y_train);
    b = performance_measure(label, Y_train);
    'nerv nie wieder'
    err = classification_error(label, Y_train);
    disp(a);
    disp(b);
    disp(err);
end


%% get information for different classes
sizes = zeros(1, 5);
for i=1:5
    sizes(i) = mean(tweet_length(Y_train==i, :));
end

histogram(tweet_length(Y_train==1, :));
hold on
% histogram(tweet_length(Y_train==2, :));
% hold on
histogram(tweet_length(Y_train==3, :));
% hold on
% histogram(tweet_length(Y_train==4, :));
hold on
histogram(tweet_length(Y_train==5, :));

%% plot histogramm tweet length

for i = 1:5
    [N,edges] = histcounts(tweet_length(Y_train==i, :));
    B=mean([edges(1:end-1);edges(2:end)]);
    plot(B, N);
    hold on 
end

%% plot  word frequency

word_frequency = sum(X_train_bag,1);
plot(1:10000, sort(word_frequency, 'descend'));


%%

scatter(sparse(1,4389), tweet_length(Y_train==1, :));
scatter(sparse(1,sum(Y_train==4)), tweet_length(Y_train==4, :), '+');

X_train_bag(Y_train==3, :);
X_train_bag(Y_train==4, :);
X_train_bag(Y_train==5, :);
% scatter(U(:,2), U(:,3));
% 
% [coeff,score,latent,tsquared,explained,mu] = pca(X_train);
T = T';
scatter(U(:,1), U(:,2));
joy = U(Y_train == 1, :);
sadness = U(Y_train == 2, :);
surprise = U(Y_train == 3, :);
anger = U(Y_train == 4, :);
fear = U(Y_train == 4, :);
scatter(joy(:,1), joy(:,2), 'o');
hold on
scatter(sadness(:,1), sadness(:,2), '+')
hold on
scatter(surprise(:,1), surprise(:,2), '-')
hold on
scatter(anger(:,1), anger(:,2), 'x')
hold on
scatter(fear(:,1), fear(:,2), '(')

% Y_train = double(Y_train);
% [coeff,score,latent,tsquared,explained,mu] = pca(X_train);
% X_pca = score(:,1);
% plot(X_pca, Y_train, 'ro');
% weights = (X_pca'*X_pca)^(-1)*X_pca'*Y_train;
% hold on;
% Y_hat = weights*X_pca;
% plot(X_pca, Y_hat)
% correlation_pcr = corr(Y_train, Y_hat);


%% Q4.1



%% 