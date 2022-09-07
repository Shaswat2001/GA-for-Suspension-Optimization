# Optimization of a Double Wishbone Suspension Geometry for Off-road Vehicles using Genetic Algorithm and Machine Learning

## Introduction

This project explores methods to predict wheel alignment angles and optimize double wishbone suspension geometry for off-road vehicles. Suspension three dimensional points are evaluated using a Genetic Algorithm for desirable values of toe, camber, kingpin and castor angles. A regression methodology is employed to accurately predict these angles at all values of the bump angle. For prime vehicle performance of an ATV in bumps and droops, all four angles must lie between their specific ranges. Genetic Algorithm incorporates these constraints to determine chromosome fitness, and generate better off springs. Selection, crossover, and mutation are operated on each generation of the populations to converge towards most ideal coordinates. This repository contains implementation for our work <a href="https://ieeexplore.ieee.org/document/9852873">**Optimization of a Double Wishbone Suspension Geometry for Off-road Vehicles using Genetic Algorithm and Machine Learning**</a> published in <a href = "http://www.icmae.org">ICMAE 2022</a>.

## Project Layout 

To ease the implementation and integration of genetic algorithm and machine learning, the project is structured in the following manner - 

```
    .
    ├── Dataset                 # Excel Sheets containing suspension data
    |
    ├── Models                  # Gaussian Regression Models stored as a mat file
    |
    ├── Python                  # Python implementation of GA and ML is also provided
    │   ├── Population          # Dataset containing different excel sheets
    │   ├── ML_Model.h5         # Keras Model
    │   └── Genetic.py          # Genetic Algorithm that returns the optimized geometry
    |
    ├── Dataset_Create.m                 # Loads the dataset initially from excels sheets
    ├── Prepare_Dataset.m                # Prepares the dataset for optimization at every iteration
    ├── Roulette_Wheel_Selection.m       # Selection Algorithm
    ├── crossover.m                      # Crossover Algorithm
    ├── mutation.m                       # Mutation Algorithm
    ├── fitness_function.m               # Fitness Function used for optimization
    └── Genetic_Algorithm.m              # Optimises the suspension geometry
    
```

## Contact

If you have any questions, please let me know:

- Shaswat Garg {[sis_shaswat@outlook.com]()}
