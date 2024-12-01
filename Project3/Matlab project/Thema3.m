clc, clearvars, clear

f = @(x1,x2) (1/3) .* (x1.^2) + 3.*(x2.^2);

%Το σημείο εκκίνησης (-5,10) είναι εφικτό. Ο αλγόριθμος καταλήγει στο ολικό
%ελάχιστο, όμως για να φτάσει εκεί κάνει πολλές ταλαντώσεις. Συνολικά
%χρειάζεται 1216 επαναλήψεις για να τερματίσει. Για να βελτιωθεί η σύγκλιση
%του αλγορίθμου μπορούμε να συγχρονίσουμε το γκ με το sk, δηλαδή να 
%αυξήσουμε το γκ=0.3 και να μειώσουμε το sk=1. Τότε ο αλγόριθμος συγκλίνει
%σε 32 επαναλήψεις. Αλλιώς βάζουμε ε=0.1 και συγκλίνει σε 24 επαναλήψεις.

[min_f, min_x1, min_x2, f_values] = SteepestDescentWithPRx(f, -5, 10, 0.01, 0.1, 15);
figure(1);
plot(1:length(f_values), f_values, "red");
hold on;
grid on;
xlabel('Repetitions');
ylabel('f(x1,x2) values');
title('f(x1,x2) values with respect to the number of repetitions. Starting point is (-5,10)');
legend('gamma=0.1 and sk=15');