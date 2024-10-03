x = -5:0.0001:5;

a = gca();
a.x_location = 'origin';
a.y_location = 'origin';

plot(x,log(1+2.*x));
plot(x,x.^3);
xgrid;
