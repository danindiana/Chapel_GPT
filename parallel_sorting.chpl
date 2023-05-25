use BlockDist;
use Sort;

config const numElements = 1000000;
config const filePath: string;

// Initialize a domain and distribute it over all locales.
const DataSpace = {1..numElements} dmapped Block(boundingBox={1..numElements});

// Initialize a distributed array to hold the data.
var data: [DataSpace] real;

// Load the data from a file.
var file = open(filePath, iomode.r);
var reader = file.reader();
for i in DataSpace {
  data[i] = reader.read(real);
}
reader.close();
file.close();

// Perform error checking to ensure the data is valid.
for datum in data {
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
