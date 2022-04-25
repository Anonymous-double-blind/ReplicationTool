function  plot_bubblechart(category,category_percentage)
%PLOT_BUBBLECHART Summary of this function goes here

figure;
x = [1:length(category)];
bubblechart(x,2*category_percentage,category_percentage);
end

