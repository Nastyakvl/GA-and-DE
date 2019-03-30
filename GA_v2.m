clear all;
clc;

%path = 'C:\Users\mlz02\Documents\MATLAB\DE LIBRARY';
 %addpath(genpath(path))

 %functions = [1 2 3 4 5 6 7 8 9 10]; %functions being solved
 functions = [10 9 8 7 6 5 4 3 2 1];
 %example: functions = [2 4 9];
 numF = size(functions,2);
 nTimes = 20; % Number of times in which a function is going to be solved
 dimension = 30; % Dimension of the problem
 populationSize = 100; % Adjust this to your algorithm

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
             
             mutationRate = 0.2;
             alpha = 0.6;
             
             
             %calculate probability for roulette selection
             fitnessSum = sum(1./populationFitness);
             prob = (1./populationFitness)/(fitnessSum);
              
              
             %select parents
             idx_parents = zeros(1,2);
                  
             while idx_parents(1) == idx_parents(2)
               for l = 1:2
                   idx_parents(l) = select_parent(prob);
               end                
             end

             p1 = population(idx_parents(1),:);
             p2 = population(idx_parents(2),:);                 
             
                  
             %BLX crossover     
             [ch1, ch2] = BLX(p1,p2, alpha);
             child = [ch1;ch2];
                 
            %mutation
             for l=1:2 
                child_l = child(l,:);
                
                r2 = rand;
                  if(r2<mutationRate)
                      for k=1:dimension
                          if(rand > mutationRate)
                            child_l(k) = child_l(k) + sqrt(1) * randn(1);
                         end
                      end
                  end
             end
             
             
             %calculate fitness function for childrend
             child_populationFitness = calculateFitnessPopulation_2005(fitfun, child, o, A, M, a, alpha, b); %Fitness values of all individuals (smaller value is better)
             
             %replace the population. The best child replace the worst
             %parent
             [best_child, best_idx] = min(child_populationFitness);
             [~, w_idx] = max(populationFitness);
             population(w_idx,:) = child(best_idx,:);
             populationFitness(w_idx) = best_child;
             bestSolutionFitness = min(populationFitness);
             currentEval = currentEval + 2;
                           
         end

         % best individual
         bestSolutionFitness = min(populationFitness);
         fprintf('%dth run, The best individual fitness is %d\n', t, bestSolutionFitness);
         sum_fitness = sum_fitness + bestSolutionFitness;

    end
    
    %average
    fprintf('sum fitness is %d\n', sum_fitness/20);

end