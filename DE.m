clear all;
clc;

%path = 'C:\Users\mlz02\Documents\MATLAB\DE LIBRARY';
 %addpath(genpath(path))

 %functions = [1 2 3 4 5 6 7 8 9 10]; %functions being solved
 functions = 2;
 %example: functions = 1;
 %example: functions = [2 4 9];
 numF = size(functions,2);
 nTimes = 20; % Number of times in which a function is going to be solved
 dimension = 30; % Dimension of the problem
 populationSize = 70; % Adjust this to your algorithm

 for i = 1:numF

    fitfun = functions(i); %fitfun is the function that we are solving

    fprintf('\n-----  Function %d started  -----\n\n', fitfun);

    sum_fitness = 0;
    for t = 1:nTimes

         maxEval = 10000*dimension; % maximum number of evaluation
         [value, upper,lower,objetiveValue, o, A, M, a, alpha, b] = getInformation_2005(fitfun, dimension);

         currentEval = 0;

         % Start generating the initial population

         population = zeros(populationSize, dimension);

         for j =1:populationSize

             population(j,:) = lower + (upper-lower).*rand(1,dimension);

         end

         populationFitness = calculateFitnessPopulation_2005(fitfun, population, o, A, M, a, alpha, b); %Fitness values of all individuals (smaller value is better)
         bestSolutionFitness = min(populationFitness);
         currentEval = currentEval + populationSize;

         % Algorithm loop
         while(objetiveValue < bestSolutionFitness && currentEval < maxEval)
                 
                scaling_factor = 0.45; 
                recomb_prob = 0.9;

                %select parents
                idx_parents = zeros(populationSize,3);
  
                tmp = zeros(1,4);
                for l = 1:populationSize
                    tmp = randperm(populationSize,4);
                    tmp = tmp(tmp ~= l);
                    idx_parents(l, :) = tmp(1:3);
                end

               
                 
                %mutation
                v = population(idx_parents(:,1),:) + scaling_factor*(population(idx_parents(:,2),:)-population(idx_parents(:,3),:));
 
               

                %mutation
                indeces = rand(populationSize,dimension) > recomb_prob;
                v((v > upper)) = upper;
                v((v < lower)) = lower;
                
                v(indeces) = population(indeces);
                

                %recombination
                fitness_v = calculateFitnessPopulation_2005(fitfun, v, o, A, M, a, alpha, b);          

                population(fitness_v < populationFitness,:) = v(fitness_v < populationFitness,:);
                populationFitness(fitness_v < populationFitness) = fitness_v(fitness_v < populationFitness);
                
                bestSolutionFitness = min(populationFitness);
                fprintf('%dth iter, The best individual fitness is %d\n', currentEval/populationSize, bestSolutionFitness);
                currentEval = currentEval + populationSize; 
         end

         % best individual
         bestSolutionFitness = min(populationFitness);
         fprintf('%dth run, The best individual fitness is %d\n', t, bestSolutionFitness);
         sum_fitness = sum_fitness + bestSolutionFitness;

    end
    
    %average
    fprintf('sum fitness is %d\n', sum_fitness/nTimes);

end
