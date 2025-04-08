# Automated Planning Project

This project explores the design and evaluation of automated planning systems using PDDL, HDDL, and HTN paradigms. A Python-based environment generator was developed to create scenarios based on a simplified industrial setting, involving agents, supplies, boxes, warehouses, and workstations. These environments are automatically translated into planning problems and solved using various planners including FF, Downward, Dual-BFWS, Optic, and TFD.

Each task in the project introduces new domain complexities, from basic logistics to carriers, durative actions, HTN decomposition, and ROS2 execution through PlanSys2.

## Project Structure

The project is organized as follows:

- `test_interactive.ipynb`: Jupyter notebook to interactively generate and solve specific environments.
- `test_generate_all.ipynb`: Automatically generates and solves all predefined environments for each task.

### src

- `environment_generator.py`: Generates environments based on configuration parameters.
- `environment_toPDDL.py`: Translates Python environments into PDDL or HDDL files.
- `entities.py`: Classes for agents, boxes, supplies, carriers, warehouses, and workstations.
- `functions.py`: Utilities for plan retrieval via `planutils` and output presentation.

### task_problems

- `problem_1` to `problem_5/`: Each folder contains:
  - `domain.pddl` or `domain.hddl`: Planning domain file for the task.
  - `Environments/`: Subfolders (`environment_0`, `environment_1`, ...) containing problems and generated plans.
  - `environment_configurations.json`: JSON with settings for environment generation.
  - In `problem_5/`, a ROS2 PlanSys2 package (`p5_pkg/`) is included.

## Tasks Overview

### Problem 1 – Basic Logistics

- **Domain**: Agents carry boxes with supplies to workstations.
- **Planners**: FF, Downward (LAMA, A\*, CEA), Dual-BFWS (heuristic and novelty-based configs).
- **Focus**: Basic grid navigation, supply delivery, reusability of boxes.

### Problem 2 – Carriers and Capacity

- **Extension**: Agents have carriers with limited capacity.
- **Two versions**:
  - Predicate-based (standard PDDL).
  - Function-based (with `carrier-load`, `carrier-capacity` and cost minimization).
- **Focus**: Resource tracking, plan cost optimization.

### Problem 3 – HTN Planning

- **Language**: HDDL with hierarchical task decomposition.
- **Planner**: Panda.
- **Focus**: Structured plan generation for delivery tasks with abstract tasks and methods.

### Problem 4 – Durative Actions

- **Language**: Temporal PDDL.
- **Planners**: TFD, Optic (default, hill-climbing, early tie-breaking).
- **Focus**: Parallel execution, action durations, synchronization.

### Problem 5 – ROS2 Integration

- **Planner**: PlanSys2 (Optic).
- **Package**: ROS2 C++ package simulating planning and execution of Problem 4.
- **Focus**: Full pipeline from domain to action execution using real-time infrastructure.

## Planners

The following planners were evaluated using [planutils](https://github.com/AI-Planning/planutils):

- `ff`: Fast-Forward (baseline planner)
- `downward`: LAMA, A\*, CEA, greedy configs
- `dual-bfws-ffparser`: Width-based planning
- `metric-ff`: Fast-Forward with support for fluents
- `optic`: Temporal planner for durative actions
- `tfd`: Temporal Fast-Downward
- `panda`: HTN planner for hierarchical tasks
- `plansys2`: ROS2-compatible planning framework

All planner calls are standardized using:
```python
request_plan(
    env_folder=<path>,
    planner=<planner_name>,
    args=<planner_args>,
    lang=<pddl|hddl>,
    args_before=<extra_flags>
)
```