function output = probability_to_class(probabilities)
    % input: probabilities mx5 vector
    % output: class with least cost
    % (1 for joy, 2 for sadness, 3 for surprise, 4 for anger, 5 for fear)
    
    costs = [0 3 1 2 3; 4 0 2 3 2; 1 2 0 2 1; 2 1 2 0 2; 2 2 2 1 0];
    [~, output] = min(probabilities*costs, [], 2);
end
