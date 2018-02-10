function [adjusted] = downweigh(original)
    adjusted = original;
    for i=1:size(adjusted, 1)
        if max(adjusted(i, :)) < 0.5
            adjusted(i, :) = adjusted(i, :)/1.5;
        end
    end
end
