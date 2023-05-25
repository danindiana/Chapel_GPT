use BlockDist;

// Define the limit up to which we want to find prime numbers.
config const n = 100;

// Check that the limit is at least 2.
if n < 2 {
  writeln("Error: the limit must be at least 2");
  return;
}

// Define a 1D domain and distribute it over all locales.
const ProblemSpace = {2..n} dmapped Block(boundingBox={2..n});

// Define a boolean array over the distributed domain to represent the sieve.
// Initially, all numbers are considered potential primes.
var sieve: [ProblemSpace] bool = true;

// Perform the Sieve of Eratosthenes in parallel.
forall p in ProblemSpace {
  // If p is a prime, mark its multiples as non-prime.
  if sieve[p] {
    const start = 2*p;
    const end = n;
    const step = p;
    for i in start..end by step {
      sieve[i] = false;
    }
  }
}

// Print the prime numbers.
for i in ProblemSpace {
  if sieve[i] {
    writeln(i);
  }
}
