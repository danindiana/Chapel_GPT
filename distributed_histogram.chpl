use BlockDist;
use Map;

// Define the size of the input data.
config const n = 100;

// Define the range of the input data.
config const dataRange = 1..10;

// Define the domain and distribute it over all locales.
const DataSpace = {1..n} dmapped Block(boundingBox={1..n});

// Generate some random input data within the specified range.
var Data: [DataSpace] int = [i in DataSpace] dataRange.first + rand(dataRange.size):int;

// Define a map to hold the histogram.
var histogram: domain(map(int,int)) dmapped Block(boundingBox=DataSpace);

// Compute the histogram in parallel.
forall d in Data with (+ reduce into histogram) {
  histogram.add((d, 1));
}

// Print the histogram.
for (bin, count) in histogram {
  writeln("Value ", bin, " occurred ", count, " times");
}
