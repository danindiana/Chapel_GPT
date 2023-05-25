use BlockDist;

config const numIndividuals = 1000;  // Number of individuals in the population.
config const stringLength = 100;    // Length of the binary strings.
config const numGenerations = 1000; // Number of generations to evolve.
config const exchangeInterval = 100; // How often to exchange individuals between nodes.

// Initialize a domain for the individuals and distribute it over all locales.
const IndividualsSpace = {1..numIndividuals} dmapped Block(boundingBox={1..numIndividuals});

// Initialize a distributed array to hold the population.
var population: [IndividualsSpace] [1..stringLength] int;

// Initialize the population with random binary strings.
forall individual in population {
  for bit in individual do bit = if rand() < 0.5 then 0 else 1;
}

// Evolve the population for a number of generations.
for generation in 1..numGenerations {
  // Each node evolves its local population in parallel.
  forall individual in population {
    // Choose a random bit to mutate.
    var bitToMutate = 1 + rand(stringLength):int;
    // Flip the bit.
    individual[bitToMutate] = 1 - individual[bitToMutate];
  }

  // Periodically, each node exchanges some individuals with its neighbors.
  if generation % exchangeInterval == 0 {
    var localPopulation = population.localSubdomain();
    if localPopulation.size > 1 {
      // Choose a random individual to send to each neighbor.
      var individualToSend = population[localPopulation.first() + rand(localPopulation.size):int];
      // Send the individual to each neighbor.
      for neighbor in localPopulation {
        if neighbor != here.id {
          population[neighbor] = individualToSend;
        }
      }
    }
  }
}

// Find and print the best solution.
var bestIndividual = population[1];
var bestScore = + reduce bestIndividual;
for individual in population {
  var score = + reduce individual;
  if score > bestScore {
    bestIndividual = individual;
    bestScore = score;
  }
}
writeln("Best individual: ", bestIndividual);
writeln("Score: ", bestScore);
