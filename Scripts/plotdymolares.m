function varsout = plotdymolares(fname,vars2plot)

load(fname)
t = data_2(1,:);
vars = data_2(2:end,:);
names = (name(:,2:end))';
varsout = vars(vars2plot,:);

hfig = figure;
plot(t,vars(vars2plot,:))
legend(names(vars2plot,:))
grid on
saveas(hfig,[fname,'.eps'],'epsc')
end