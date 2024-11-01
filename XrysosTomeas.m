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
            a = x1;
            x1 = x2;
            x2 = a + g*(b-a);
            fx1_value = fx2_value;
            fx2_value = f(x2);
            calls = calls + 1;
        else
            b = x2;
            x2 = x1;
            x1 = a + (1-g)*(b-a);
            fx2_value = fx1_value;
            fx1_value = f(x1);
            calls = calls + 1;

        end
    end
    a_values = [a_values, a];
    b_values = [b_values, b];

end

