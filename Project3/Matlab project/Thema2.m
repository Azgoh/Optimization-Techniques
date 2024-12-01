clc, clearvars, clear

f = @(x1,x2) (1/3) .* (x1.^2) + 3.*(x2.^2);

%Το σημείο εκκίνησης (5,-5) είναι εφικτό. Η μέθοδος ταλαντώνεται και δεν 
%συγκλίνει.

[min_f, min_x1, min_x2, f_values] = SteepestDescentWithPRx(f, 5, -5, 0.01, 0.5, 5);
figure(1);
plot(1:length(f_values), f_values, "red");
hold on;
grid on;
xlabel('Repetitions');
ylabel('f(x1,x2) values');
title('f(x1,x2) values with respect to the number of repetitions. Starting point is (5,-5)');
legend('gamma=0.5 and sk=5');
