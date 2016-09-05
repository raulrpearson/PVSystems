function subplotarray(A,n)
% Plot rows of array in their own subplot
% A is array of data to plot
% n is number of rows of the array of subplots

figure
nplots = size(A,1);
for i=1:nplots
    subplot(n,ceil(nplots/n),i)
    plot(A(i,:))
end