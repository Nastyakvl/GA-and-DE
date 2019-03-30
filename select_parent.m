function idx = select_parent(prob)
    r = rand;
    sumProb = prob(1);
    k = 1;
    while r > sumProb
        sumProb = sumProb + prob(k+1);
        k = k + 1;
    end
    idx = k; 
end