# Chapel_GPT

GPT-generated Chapel Language parallel and distributed computing programs demonstrating high-performance computing capabilities.

## Table of Contents
- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Program Categories](#program-categories)
- [Getting Started](#getting-started)
- [Git Workflow](#git-workflow)
- [Architecture](#architecture)
- [Installation](#installation)
- [Contributing](#contributing)

## Overview

This repository contains a collection of Chapel language programs that showcase:
- **Data Parallelism**: Trivially use cores across laptops, clusters, or supercomputers
- **Task Parallelism**: Create concurrency within a node or across systems
- **Distributed Arrays**: Leverage thousands of nodes' memories and cores
- **Global Namespace**: Direct access to local or remote variables
- **Python-like Syntax**: Easy-to-read, high-performance code

## Repository Structure

```mermaid
graph TD
    A[Chapel_GPT Repository] --> B[Parallel Programs]
    A --> C[Distributed Programs]
    A --> D[Utilities]
    A --> E[Documentation]
    A --> F[Installation Scripts]

    B --> B1[parallel_matrix_multiply.chpl]
    B --> B2[parallel_matrix_multiplyv2.chpl]
    B --> B3[parallel_primes.chpl]
    B --> B4[parallel_sorting.chpl]
    B --> B5[parallel_sorting_DEMO.chpl]

    C --> C1[distributed_histogram.chpl]
    C --> C2[distributed_histogramv2.chpl]
    C --> C3[distributed_word_count.chpl]
    C --> C4[distributed_word_countv2.chpl]
    C --> C5[distributed_graph_search.chpl]
    C --> C6[distributed_graph_searchv2.chpl]
    C --> C7[distributed_genetic_algorithm.chpl]

    D --> D1[chapel_indexer.chpl]
    D --> D2[chapel_indexer_CLI.chpl]

    E --> E1[NBFTNA_proposal.txt]
    E --> E2[TODO.txt]
    E --> E3[LICENSE]

    F --> F1[install/install_script_ubuntu.sh]

    style A fill:#4A90E2,color:#fff
    style B fill:#50C878,color:#fff
    style C fill:#FF6B6B,color:#fff
    style D fill:#FFD93D,color:#000
    style E fill:#A78BFA,color:#fff
    style F fill:#FCA5A5,color:#000
```

## Program Categories

```mermaid
flowchart LR
    A[Chapel Programs] --> B[Parallel Computing]
    A --> C[Distributed Computing]
    A --> D[Algorithms]
    A --> E[Utilities]

    B --> B1[Matrix Operations]
    B --> B2[Sorting Algorithms]
    B --> B3[Prime Number Generation]

    C --> C1[Data Analysis<br/>Histograms, Word Count]
    C --> C2[Graph Algorithms<br/>BFS/DFS]
    C --> C3[Genetic Algorithms]

    D --> D1[Sieve of Eratosthenes]
    D --> D2[Parallel Sort]
    D --> D3[Matrix Multiply]

    E --> E1[Code Indexing]
    E --> E2[CLI Tools]

    style A fill:#4A90E2,color:#fff
    style B fill:#50C878,color:#fff
    style C fill:#FF6B6B,color:#fff
    style D fill:#FFD93D,color:#000
    style E fill:#A78BFA,color:#fff
```

## Getting Started

```mermaid
flowchart TD
    Start([Start]) --> A[Install Chapel]
    A --> B{Installation<br/>Successful?}
    B -->|No| C[Check Dependencies]
    C --> A
    B -->|Yes| D[Clone Repository]
    D --> E[Choose a Program]
    E --> F{Program Type?}

    F -->|Parallel| G[Single Node Execution]
    F -->|Distributed| H[Multi-Node Setup]

    G --> I[Compile with chpl]
    H --> J[Configure Locales]
    J --> I

    I --> K[Execute Program]
    K --> L{Success?}
    L -->|Yes| M[Experiment & Learn]
    L -->|No| N[Check Logs]
    N --> O[Debug]
    O --> I

    M --> End([End])

    style Start fill:#4A90E2,color:#fff
    style End fill:#4A90E2,color:#fff
    style A fill:#50C878,color:#fff
    style D fill:#50C878,color:#fff
    style M fill:#50C878,color:#fff
    style I fill:#FFD93D,color:#000
    style K fill:#FFD93D,color:#000
```

### Quick Start Commands

```bash
# 1. Install Chapel (Ubuntu)
cd install
chmod +x install_script_ubuntu.sh
./install_script_ubuntu.sh

# 2. Compile a parallel program
chpl parallel_sorting_DEMO.chpl -o sorting_demo

# 3. Run the program
./sorting_demo

# 4. For distributed execution (multi-locale)
chpl distributed_genetic_algorithm.chpl -o genetic_algo
./genetic_algo --numLocales=4
```

## Git Workflow

```mermaid
gitGraph
    commit id: "Initial commit"
    commit id: "Add parallel programs"
    branch feature/distributed-computing
    checkout feature/distributed-computing
    commit id: "Add distributed histogram"
    commit id: "Add distributed word count"
    commit id: "Add graph search"
    checkout main
    merge feature/distributed-computing
    branch feature/utilities
    checkout feature/utilities
    commit id: "Add chapel indexer"
    commit id: "Add CLI tools"
    checkout main
    merge feature/utilities
    branch feature/documentation
    checkout feature/documentation
    commit id: "Add NBFTNA proposal"
    commit id: "Update README"
    commit id: "Add Mermaid diagrams"
    checkout main
    merge feature/documentation
    commit id: "Release v1.0"
```

## Architecture

```mermaid
graph TB
    subgraph "Chapel Runtime System"
        A[User Code] --> B[Chapel Compiler]
        B --> C[Executable]
    end

    subgraph "Execution Model"
        C --> D{Execution Type}
        D -->|Single Locale| E[Local Threads]
        D -->|Multi Locale| F[Distributed Execution]
    end

    subgraph "Memory Model"
        E --> G[Shared Memory]
        F --> H[Distributed Memory]
        H --> I[Locale 1]
        H --> J[Locale 2]
        H --> K[Locale N]
    end

    subgraph "Data Structures"
        G --> L[Local Arrays]
        H --> M[Distributed Arrays<br/>Block Distribution]
        M --> N[Domain Maps]
    end

    subgraph "Parallelism"
        L --> O[forall Loops]
        M --> O
        O --> P[Task Parallelism]
        O --> Q[Data Parallelism]
    end

    style A fill:#4A90E2,color:#fff
    style C fill:#50C878,color:#fff
    style E fill:#FFD93D,color:#000
    style F fill:#FF6B6B,color:#fff
    style M fill:#A78BFA,color:#fff
```

## Project Component Interaction

```mermaid
sequenceDiagram
    participant User
    participant Compiler as Chapel Compiler
    participant Runtime as Chapel Runtime
    participant L1 as Locale 1
    participant L2 as Locale 2
    participant LN as Locale N

    User->>Compiler: Compile program
    Compiler->>Runtime: Generate executable
    User->>Runtime: Execute with --numLocales=N
    Runtime->>L1: Initialize locale
    Runtime->>L2: Initialize locale
    Runtime->>LN: Initialize locale

    L1->>Runtime: Create distributed domain
    Runtime->>L1: Allocate data segment
    Runtime->>L2: Allocate data segment
    Runtime->>LN: Allocate data segment

    par Parallel Execution
        L1->>L1: Process local data
        L2->>L2: Process local data
        LN->>LN: Process local data
    end

    L1->>Runtime: Synchronize
    L2->>Runtime: Synchronize
    LN->>Runtime: Synchronize

    Runtime->>User: Return results
```

## Program Execution Flow

```mermaid
stateDiagram-v2
    [*] --> Initialization
    Initialization --> DomainCreation
    DomainCreation --> DataDistribution
    DataDistribution --> ParallelExecution

    ParallelExecution --> LocalComputation
    ParallelExecution --> RemoteAccess

    LocalComputation --> Synchronization
    RemoteAccess --> Synchronization

    Synchronization --> MoreWork
    MoreWork --> ParallelExecution: Yes
    MoreWork --> ResultAggregation: No

    ResultAggregation --> OutputResults
    OutputResults --> [*]

    note right of DataDistribution
        Block, Cyclic, or
        Custom Distribution
    end note

    note right of ParallelExecution
        forall loops execute
        in parallel across locales
    end note
```

## Installation

### Prerequisites
- GCC 7.0 or later
- Python 3.6 or later
- LLVM 12 (recommended)
- At least 4GB RAM
- Linux, macOS, or WSL2 on Windows

### Ubuntu/Debian Installation

```bash
cd install
chmod +x install_script_ubuntu.sh
./install_script_ubuntu.sh
```

The installation script will:
1. Install required dependencies
2. Download Chapel 1.29.0
3. Compile and install Chapel
4. Configure environment variables

### Verify Installation

```bash
chpl --version
```

You should see output similar to:
```
chpl version 1.29.0
```

## Program Descriptions

### Parallel Programs

| Program | Description | Key Features |
|---------|-------------|--------------|
| `parallel_matrix_multiply.chpl` | Matrix multiplication using data parallelism | Distributed matrices, parallel computation |
| `parallel_primes.chpl` | Sieve of Eratosthenes for finding primes | Distributed sieve array, parallel algorithm |
| `parallel_sorting.chpl` | Parallel sorting algorithm | Block distribution, parallel sort |

### Distributed Programs

| Program | Description | Key Features |
|---------|-------------|--------------|
| `distributed_histogram.chpl` | Distributed histogram calculation | Remote data access, parallel aggregation |
| `distributed_word_count.chpl` | Parallel word counting | Distributed text processing |
| `distributed_graph_search.chpl` | BFS/DFS on distributed graphs | Task parallelism, distributed data structures |
| `distributed_genetic_algorithm.chpl` | Parallel genetic algorithm | Population distribution, periodic exchange |

### Utilities

| Program | Description | Key Features |
|---------|-------------|--------------|
| `chapel_indexer.chpl` | Code indexing utility | File processing |
| `chapel_indexer_CLI.chpl` | Command-line indexer | CLI interface |

## Contributing

```mermaid
flowchart LR
    A[Fork Repository] --> B[Create Feature Branch]
    B --> C[Write Code]
    C --> D[Test Locally]
    D --> E{Tests Pass?}
    E -->|No| C
    E -->|Yes| F[Commit Changes]
    F --> G[Push to Fork]
    G --> H[Create Pull Request]
    H --> I[Code Review]
    I --> J{Approved?}
    J -->|No| K[Address Feedback]
    K --> C
    J -->|Yes| L[Merge to Main]

    style A fill:#4A90E2,color:#fff
    style L fill:#50C878,color:#fff
    style E fill:#FFD93D,color:#000
    style J fill:#FFD93D,color:#000
```

### Contribution Guidelines

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Write** clean, documented code
4. **Test** your changes thoroughly
5. **Commit** with clear messages (`git commit -m 'Add amazing feature'`)
6. **Push** to your branch (`git push origin feature/amazing-feature`)
7. **Open** a Pull Request

## Documentation

- **NBFTNA_proposal.txt**: Proposal for non-blocking fat-tree network architecture using Chapel
- **TODO.txt**: List of planned programs and features
- **Chapel Documentation**: [https://chapel-lang.org/docs/](https://chapel-lang.org/docs/)

## License

This project is licensed under the terms specified in the LICENSE file.

## Resources

- [Chapel Language Official Site](https://chapel-lang.org/)
- [Chapel Documentation](https://chapel-lang.org/docs/)
- [Chapel GitHub Repository](https://github.com/chapel-lang/chapel)
- [Chapel Discourse Community](https://chapel.discourse.group/)

## Acknowledgments

Programs generated with assistance from GPT to demonstrate Chapel's powerful parallel and distributed computing capabilities.

---

**Note**: These programs are designed to run on systems ranging from single laptops to massive supercomputers with thousands of nodes. Adjust the `numLocales` configuration variable to match your available hardware.
