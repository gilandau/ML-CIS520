function [ cells ] = cellarray ( vectorC, vectorG )
%% cellarray
%
%   This function is part of the Gridsearch main function.
%   It creates array of cells containing the strings needed for the input
%   of the svmtrain function from LibSvm support vector library.
%

%% Cells
%
%   This part creates the initial empty cell array.
%

    cells = cell ( length ( vectorC ), length ( vectorG ) );

%% Numbers to strings
%
%   This part converts the input numeric vectors into strings.
%
 
    C = num2str ( vectorC ( : ) );
          
    G = num2str ( vectorG ( : ) );
  
%% Main loop
%
%   This part evaluates the main for loop for creating multiple strings and
%   storing them in the cells array.
%
        for i = 1 : length ( vectorC )      %Start for loop for C parameter.
      
            for n = 1 : length ( vectorG )  %Start for loop for G parameter.
          
                cells ( i, n ) = cellstr ( ...         
           [ '-q -s 3 -t 1 -m 3000 -h 0 -g ', G(n,:), ' -c ', C(i,:) ] );  
           
                                            %Create string.
                                            
%If different settings for the svmtrain are needed this string is changed.
                                                    
            end                             %End for loop for C parameter.
      
        end                                 %End for loop for G parameter.
    
end