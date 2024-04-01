x = -pi:0.01:pi;

y = sin(x);

ynoise = y+(rand(1,length(y))-0.5)*0.2;

plot(x,y,'r');
hold on;

plot(x,ynoise);
hold off;