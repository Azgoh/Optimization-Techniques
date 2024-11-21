clc, clearvars, clear

[X, Y] = meshgrid(-3:0.1:3);
f = @(x,y)x.^5 .* exp(-x.^2 - y.^2);

surf(X,Y,f(X,Y)); %3D plot
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('f(x,y) = x^5 * e^{-x^2 - y^2} plot');

figure(2);
contourf(X,Y,f(X,Y)); %Contour plot
xlabel('x');
ylabel('y');
title('Contour plot of the f(x,y) = x^5 * e^{-x^2 - y^2} function');
