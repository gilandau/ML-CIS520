%# train one-against-all models
function [posterior] = svm_multiclass(X_training, Y_training, X_test)
    addpath('./libsvm');
    numLabels = 5;
    numTest = 1;
    model = cell(numLabels,1);
    for k=1:numLabels
        disp(k);
        model{k} = svmtrain(double(Y_training==k), X_training, '-b 1');
    end

    %# get probability estimates of test instances using each model
    prob = zeros(numTest,numLabels);
    for k=1:numLabels
        disp(k);
%         [~,~,p] = svmpredict(double(testLabel==k), Y_test, model{k}, '-b 1');
        [alpha,beta,p] = svmpredict(zeros(size(X_test, 1)), X_test, model{k}, '-b 1');
        prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
    end

    %# predict the class with the highest probability
    posterior = 5;
    [~,pred] = max(prob,[],2);
    acc = sum(pred == testLabel) ./ numel(testLabel)    %# accuracy
    C = confusionmat(testLabel, pred)                   %# confusion matrix
end
