function [new] = punctuation(old)
    addpath('./data');
    load("vocabulary.mat"); 


    voc = zeros(1, size(vocabulary, 2));
    for i=1:size(vocabulary, 2)
        voc(i) = size(regexprep(char(vocabulary(i)), '[-!,.?()":;-_!@#$%^&*_+1234567890<>?:"{}|\,./;/]', ''), 2) ~= size(char(vocabulary(i)), 2);
    end

    [row,col] = find(logical(old));
    X_train_len = old;
    for i=1:size(row, 1)
        if voc(col(i))
            X_train_len(row(i), col(i)) = 0;
        end
    end
 
    big_words = full(sum(X_train_len, 2));
    no_words = full(sum(old, 2));
    new_feat = sparse([big_words, no_words-big_words]);
    new = new_feat;
 
end