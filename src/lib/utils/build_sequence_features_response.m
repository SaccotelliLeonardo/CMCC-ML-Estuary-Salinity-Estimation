function [x, y] = build_sequence_features_response(df, window_size, requested_features, output)
%BUILD_SEQUENCE_FEATURES_RESPONSE Function used to generate sequence of features and response.
%   Function is used to generate sequence of features and response. User should select
% what features should be considered, as well as the different timestamp
% for each feature. 
% 1. df is the dataset
% 2. window_size is the number of timestamp 
% 3. requested_features the list of features used in the sequence of data
% 4. the name of the output in df
% The outup will be x and y, which are the features and the response.
x = []; y = []; j = 1;
for i=1:height(df) - window_size
    row = table2cell(df(i:i+window_size-1, requested_features));
    row = cell2mat(row);
    x{j} = transpose(row);

    label = table2cell(df(i+window_size, output));
    label = cell2mat(label);
    y{j} = label;
    j = j+1;
end

x = transpose(x);
y = transpose(y);
end