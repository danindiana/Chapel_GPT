use BlockDist;

config const numNodes = 100;   // Number of nodes in the graph
config const sourceNode = 1;   // Source node for the BFS
config const filePath: string; // File path to load the graph

// Initialize a domain for the nodes and distribute it over all locales.
const NodesSpace = {1..numNodes} dmapped Block(boundingBox={1..numNodes});

// Initialize a domain for the graph and distribute it over all locales.
const GraphSpace = {1..numNodes, 1..numNodes} dmapped Block(boundingBox={1..numNodes, 1..numNodes});

// Initialize the adjacency matrix (the graph).
var graph: [GraphSpace] int;

// Load the graph from the file.
var file = open(filePath, iomode.r);
var reader = file.reader();
for (i,j) in GraphSpace {
  graph[i,j] = reader.read(int);
}
reader.close();
file.close();

// Initialize the distances.
var dist: [NodesSpace] int = max(int);
dist[sourceNode] = 0;

// Initialize the BFS queue.
var queue: [1..0] int;

// Perform the BFS.
queue.push_back(sourceNode);
while queue.size > 0 {
  var node = queue.pop_front();
  for neighbor in NodesSpace {
    if graph[node,neighbor] != 0 && dist[neighbor] == max(int) {
      dist[neighbor] = dist[node] + 1;
      queue.push_back(neighbor);
    }
  }
}

// Print the distances.
for (i,nodeDist) in zip(NodesSpace, dist) {
  writeln("Distance from ", sourceNode, " to ", i, " is ", nodeDist);
}
