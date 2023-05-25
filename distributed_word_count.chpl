use BlockDist;
use IO;
use Map;
use Sort;

config const filePath: string;

// Read the file.
var file = open(filePath, iomode.r);
var reader = file.reader();
var words: [1..0] string;
for word in reader.words() {
  words.push_back(word);
}
reader.close();
file.close();

// Distribute the words across all locales.
const WordsSpace = {1..words.size} dmapped Block(boundingBox={1..words.size});
var distWords: [WordsSpace] string = words;

// Define a map to hold the word counts.
var wordCounts: domain(map(string,int)) dmapped Block(boundingBox=WordsSpace);

// Count the words in parallel.
forall word in distWords with (+ reduce into wordCounts) {
  wordCounts.add((word, 1));
}

// Print the word counts.
writeln("Word counts:");
var sortedKeys = sort(wordCounts.keys());
for word in sortedKeys {
  writeln(word, ": ", wordCounts[word]);
}
