use FileSystem;
use IO;

// The path to the directory that we want to index.
config const path = '.';

// Recursively traverses the directory at 'path'.
proc indexFiles(path: string) {
  try {
    var dir = opendir(path);
    for file in dir {
      var name = joinPath(path, file);
      if isFile(name) {
        writeln("File: ", name);
      } else if isDir(name) {
        writeln("Directory: ", name);
        indexFiles(name);
      }
    }
  } catch {
    writeln("Error: could not open ", path);
  }
}

// The main program.
proc main() {
  indexFiles(path);
}
