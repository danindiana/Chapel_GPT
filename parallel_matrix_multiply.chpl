use BlockDist;

// Define a 2D domain and distribute it over all locales.
const ProblemSpace = {1..n, 1..n} dmapped Block(boundingBox={1..n, 1..n});

// Define two matrices over the distributed domain and initialize them.
var A: [ProblemSpace] real, B: [ProblemSpace] real;

forall (i,j) in ProblemSpace {
  A[i, j] = i * 0.1;
  B[i, j] = j * 0.2;
}

// Define a matrix to hold the result of the multiplication.
var C: [ProblemSpace] real;

// Perform the matrix multiplication in parallel.
forall (i,j) in ProblemSpace {
  for k in 1..n {
    C[i, j] += A[i, k] * B[k, j];
  }
}

// Print the result matrix.
writeln("C = ", C);
