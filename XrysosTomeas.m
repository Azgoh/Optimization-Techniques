function [calls, a_values, b_values] = XrysosTomeas(f, a, b, l, g)

    calls = 0;
    a_values = [];
    b_values = [];

    x1 = a + (1-g)*(b-a);
    x2 = a + g*(b-a);

    fx1_value = f(x1);
    calls = calls + 1;
    fx2_value = f(x2);
    calls = calls + 1;

    while (b-a) > l
        a_values = [a_values, a];
        b_values = [b_values, b];

        if fx1_value > fx2_value
            a = x1; %a_k+1 = x1k
            x1 = x2; %x1_k+1 = x2k
            x2 = a + g*(b-a); %x2_k+1
            fx1_value = fx2_value; %fx1_k+1 = fx_2k
            fx2_value = f(x2); %fx2_k+1 = f(x2_k+1)
            calls = calls + 1;
        else
            b = x2; %b_k+1 = x2k
            x2 = x1; %x2_k+1 = x1_k
            x1 = a + (1-g)*(b-a); %x1_k+1
            fx2_value = fx1_value; %fx2_k+1 = fx1_k
            fx1_value = f(x1); %fx1_k+1 = f(x1_k+1)
            calls = calls + 1;

        end
    end
    a_values = [a_values, a];
    b_values = [b_values, b];

end

