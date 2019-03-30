# GA-and-DE
Genetic and Differential Equation algorithms at matlab.
The algorithms are applied to 10 functions with dimension 30. These functions were proposed in the competition organized by the especial session “Real parameter optimization” in the
2005 IEEE Congress on Evolutionary Computation (CEC2005). The discription of these functions you can find at "Function description.pdf"

## GA
- selection: roulette selection
- crossover: BLX
- mutation: Gaussian mutation
- replacement: the best individual is saved and the worth parent is replaced with the best child 

Parameters of the algorithm:
1. Mutation Rate = 0.2
2. α = 0.6

## DE
Parameters of the algorithm:
1. population size = 70;
2. scaling factor = 0.45;
3. recombination probability = 0.9.
