function plot_bar(x_label,y,offset,xtickangle,ytextangle)
%PLOT_BAR Summary of this function goes here
%   Detailed explanation goes here
    figure; 
    x = [1:length(y)];
    bar(x,y);
    set(gca, 'XTick', 1:length(x_label),'XTickLabel',x_label,'XTickLabelRotation',xtickangle);
    for i = 1:length(y)                                                               
        text(x(i), double(y(i))+offset, num2str(y(i)), 'HorizontalAlignment','center', 'VerticalAlignment','middle','Rotation',ytextangle);
    end
end

