function [h1,h2] = BLX(x1, x2, alpha)
    h1 = zeros(1, length(x1));
    h2 = zeros(1, length(x1));
    for i=1:length(x1)
        c_max = max(x1(i), x2(i));
        c_min = min(x1(i), x2(i));
        I = c_max - c_min;
        xmin = c_min - I * alpha;
        xmax = c_max + I *alpha;
        h1(i) = xmin+rand*(xmax-xmin);
        h2(i) = xmin+rand*(xmax-xmin);
    end

end