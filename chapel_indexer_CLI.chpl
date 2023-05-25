use FileSystem;
use IO;

// Recursively traverses the directory at 'path' and writes output to 'outFile'.
proc indexFiles(path: string, outFile: channel(writing)) {
  try {
    var dir = opendir(path);
    for file in dir {
      var name = joinPath(path, file);
      if isFile(name) {
        outFile.writeln("File: ", name);
      } else if isDir(name) {
        outFile.writeln("Directory: ", name);
        indexFiles(name, outFile);
      }
    }
  } catch {
    outFile.writeln("Error: could not open ", path);
  }
}

// The main program.
proc main() {
  // Prompt user for directory path and output file name.
  writeln("Enter the path to the directory you want to index:");
  var path: string;
  read(path);

  writeln("Enter the name of the output file:");
  var fileName: string;
  read(fileName);

  // Open the output file for writing.
  var f = open(fileName, iomode.cw);
  var writer = f.writer();

  // Index the files and write the output.
  indexFiles(path, writer);

  // Close the output file.
  writer.close();
  f.close();
}
