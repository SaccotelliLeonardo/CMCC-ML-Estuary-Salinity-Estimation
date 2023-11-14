clc
clear
close all

addpath(genpath("..\..\data\"));
addpath(genpath("..\lib"));

%% Read the raw dataset
sul_dataset_read = import_dataset("raw\raw-dataset-sul.xlsx", 10, "A2:J1462", "Sheet1", ...
    ["ID","Date","Qriver", "Qll", "Qtidef", "Sll", "Socean", "Sul", "Sul_EBM", "Dataset"], ...
    ["categorical","datetime", "double", "double", "double", "double","double", "double", "double", "categorical"]);
sul_dataset = sul_dataset_read;

%% Remove missed data
sul_dataset = sul_dataset(not(sul_dataset.Dataset == "Missed"),:);

%% Input request of window_size & requested_features
window_size = "";
while (true)
    window_size = input("Enter the number of previous day to be considered: ");
    if isempty(window_size)
        disp("Empty value for 'window_size'");
    else
        break;
    end
end

requested_features = "";
while (true)
    requested_features = input("Enter the name of features to be considered. " + ...
        "\nPossible choice are: Qriver, Qll, Qtidef, Sll, Socean, Sul.\nAn example of request is:" + ...
        " 'Qriver,Qll,Sul'. Enter: ", "s");
    if isempty(requested_features)
        disp("Empty value for 'requested_features'"); 
    else
        requested_features = split(requested_features, ",");
        break;
    end
end

%% Build sequence of features and response
[x, y] = build_sequence_features_response(sul_dataset, window_size, requested_features, "Sul");

%% Save the sequense dataset
save(strcat("..\..\data\processed\input-features-sul-lstm-", ...
    string(window_size),"-input_day-", ...
    strjoin(requested_features, "_"),".mat"), ...
    "x","y");