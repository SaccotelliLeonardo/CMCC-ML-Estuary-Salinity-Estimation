function [f] = create_perfect_fit(resumePredictions,algorithm_names,addBoundPerfectFit, percentageBoundPerfectFit)
%CREATE_PERFECT_FIT This function plot a perfect predictions plot
%   Input:
%   1) resumePredictions - table with a summary of observed and predicted
%   values
%   2) algorithm_names - string array with the names of the trained models
%   3) addBoundPerfectFit - boolean value to add or not a bound on the
%   perfect predictions line
%   4) percentageBoundPerfectFit - percentage bound to be added on the
%   perfect predictions plot

    f = figure;
    %tiledlayout(2,2);
    %f.Position = [0 -5 1068 1001];
    tiledlayout(1,3);
    f.Position = [129,46,1532,460];
    for i = 1:numel(algorithm_names)
        nexttile
        plotPerfectFit( ...
            resumePredictions(:,1), ...
            resumePredictions(:,i+1), ...
            algorithm_names(i), ...
            addBoundPerfectFit, ...
            percentageBoundPerfectFit);
    end
end

function [] = plotPerfectFit(obs, pred, modelName, addBound, percentageBound)
    if (istable(obs))
        obs = table2array(obs);
    end
    
    if(istable(pred))
        pred = table2array(pred);
    end
    hAx=gca;                  
    legendName = {'Observations','Perfect prediction'};
    plot(obs, pred, 'o','MarkerSize', 5, 'MarkerFaceColor', [0.00,0.45,0.74], ...
        'Color', [0.00,0.00,1.00]);
    hold on;
    xy = linspace(0, 40, 40);
    plot(xy,xy,'k-','LineWidth',2);
    if(addBound)
        xyUpperBound = xy + percentageBound*xy/100;
        xyLowerBound = xy - percentageBound*xy/100;
        plot(xy,xyUpperBound, 'r--', 'LineWidth',2);
        plot(xy,xyLowerBound, 'r--', 'LineWidth',2);
        legendName = {"Observations","Perfect prediction", ...
            strcat(string(percentageBound), "% of deviation")};
    end
    hAx.LineWidth=1.4;
    xlim([0 40]);
    ylim([0 40]);
    xticks([0 5 10 15 20 25 30 35 40]);
    xticklabels({'0','5','10','15','20','25','30','35','40'});
    yticks([0 5 10 15 20 25 30 35 40]);
    yticklabels({'0','5','10','15','20','25','30','35','40'});
    xlabel('True response (psu)');
    ylabel('Predicted response (psu)');
    title(modelName);
    legend(legendName,'Location','northwest');
    set(gca,'FontSize',14);
    grid on;
    hold off;
end