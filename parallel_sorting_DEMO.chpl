use BlockDist;
use Sort;

config const numElements = 1000000;

// Initialize a domain and distribute it over all locales.
const DataSpace = {1..numElements} dmapped Block(boundingBox={1..numElements});

// Initialize a distributed array to hold the data.
var data: [DataSpace] real;

// Generate data in parallel
forall i in DataSpace {
  data[i] = i:real + (numElements - i):real/2.0;
}

// Perform error checking to ensure the data is valid.
forall datum in data {
  if isnan(datum) {
    writeln("Error: Data contains non-numeric values.");
    return;
  }
}

// Sort the data in parallel.
sort(data);

// Print the sorted data.
for datum in data {
  writeln(datum);
}
