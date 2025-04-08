import subprocess
from tokenize import String
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import random
from collections import namedtuple
import os

# Represents a coordinate position with x and y values.
Position = namedtuple('Position', ['x', 'y'])

def request_plan(env_folder, planner, args, lang='pddl', args_before=''):
    """
    Executes a planning command based on the specified planner and environment,
    then processes and saves the output plan if found.
    """
    # Paths for domain, problem, and the output plan.
    domain_path = f'{env_folder}/domain.{lang}'
    problem_path = f'{env_folder}/problem.{lang}'
    output_plan_path = f'{env_folder}/{planner}_plan.{lang}'

    # Construct command based on the specified planner
    command = ''
    if planner in ['lama-first', 'ff', 'tfd', 'metric-ff']:
        command = f'planutils run {planner} {domain_path} {problem_path} -- {args}'
    elif planner == 'optic':
        command = f'planutils run {planner} -- {args} {domain_path} {problem_path}'

    elif planner == 'dual-bfws-ffparser':
        command = f'planutils run {planner} -- {domain_path} {problem_path} -- {args}'
    elif planner == 'panda':
        command = f'java -jar ./src/PANDA.jar {args} {domain_path} {problem_path}'
    elif planner == 'downward':
        command = f'planutils run {planner} -- --plan-file {output_plan_path} {args_before} {domain_path} {problem_path} {args}'

    print(f' - Command: {command}')
    # Execute the planning command
    result = subprocess.run(command, capture_output=True, text=True, shell=True)

    # Process output based on the planner used, then save the plan if found.
    # This part is strictly related to the current use cases. It may not work properly with new planner configurations.

    if planner == 'optic':
        print(f'in optin {env_folder}')
        if not 'task_problems/problem_4' in env_folder and not 'task_problems/problem_5' in env_folder:
            plan_details = extract_plan_details_0(result.stdout)
        else:
            plan_details = extract_plan_details_1(result.stdout)
        
        print(plan_details)
        # Save or report based on finding a solution.
        if "Solution Found" in plan_details:
            with open(output_plan_path, 'w') as f:
                f.write(plan_details)
            print(f" -> Plan found, saved at: {output_plan_path}")
        else:
            print(" -> No plan found")


    elif planner == 'dual-bfws-ffparser':
        
        generated_plan_path = f'plan'
        execution_details_path = f'execution.details'

        if os.path.exists(generated_plan_path):
            os.remove(generated_plan_path)

        if os.path.exists(execution_details_path):
            os.rename(execution_details_path, output_plan_path)
            print(f" -> Plan found, saved at: {output_plan_path}")
        else:
            print(" -> No plan found")

    elif planner == 'lama-first':
        generated_plan_path = f'sas_plan'
        if os.path.exists(generated_plan_path):
            os.rename(generated_plan_path, output_plan_path)
            print(f" -> Plan found, saved at: {output_plan_path}")
        else:
            print(" -> No plan found")

    elif planner in ['ff', 'metric-ff']:
        generated_plan_path = f'{env_folder}/problem.pddl.plan'
        if os.path.exists(generated_plan_path):
            os.rename(generated_plan_path, output_plan_path)
            print(f" -> Plan found, saved at: {output_plan_path}")
        else:
            print(" -> No plan found")
            
    elif planner == 'panda':
        marker = "SOLUTION SEQUENCE"
        if marker in result.stdout:

            plan_start_index = result.stdout.index(marker) + len(marker)
            plan_text = result.stdout[plan_start_index:].strip()
            
            if plan_text:
                with open(output_plan_path, 'w') as plan_file:
                    plan_file.write(plan_text)
                print(f" -> Plan found, saved at: {output_plan_path}")
            else:
                print(" -> No plan found or empty plan")
        else:
            print(" -> No plan found")

    elif planner == 'tfd':
        plan_details = extract_plan_details_2(result.stdout)

        if "Found new plan:" in plan_details:
            with open(output_plan_path, 'w') as f:
                f.write(plan_details)
            print(f" -> Plan found, saved at: {output_plan_path}")
        else:

            print(" -> No plan found")

    return result

def extract_plan_details_0(output):
    """
    FOR OPTIC OUTPUT (NO DURATIVE-ACTIONS)

    Extract plan details starting after "; Plan found with metric" until ";;;; Solution Found".
    """
    lines = output.split('\n')
    plan_start = False
    plan_lines = []

    for line in lines:
        if ";;;; Solution Found" in line and plan_start:
            plan_lines.pop()  # Remove the last line, as it's part of the end condition
            break
        if "; Plan found with metric" in line or plan_start:
            plan_start = True
            plan_lines.append(line)

    return "\n".join(plan_lines)

def extract_plan_details_1(output):
    """
    FOR OPTIC OUTPUT (WITH DURATIVE-ACTIONS)

    Extract plan details starting at ";;;; Solution Found" line.
    """

    lines = output.split('\n')
    plan_start = False
    plan_lines = []

    for line in lines:
        print(line)
        if "Solution Found" in line:
            plan_start = True
            plan_lines.append("Solution Found")
            continue
        if plan_start:
            plan_lines.append(line)

    return "\n".join(plan_lines)

def extract_plan_details_2(output):
    """
    FOR TFD OUTPUT

    Extracts lines from the output starting after the line containing "New solution has been found."
    """
    lines = output.split('\n')
    plan_start = False  # Flag to start recording lines
    plan_lines = [] 

    for line in lines:
        if "New solution has been found." in line:
            plan_start = True
            continue
        if plan_start:
            plan_lines.append(line)

    return "\n".join(plan_lines)


def select_random_one_position(matrix, exclude_positions=[]):
    """
    Selects a random position with a value of 1 or 3 in the matrix, excluding specified positions.
    (1 -> free position, 2 -> warehouse position, 3 -> workstation position, 0 -> inaccessible position)

    """
    ones_positions = np.where(np.logical_or(matrix == 1, matrix == 3))
    ones_list = [Position(x, y) for (x, y) in zip(ones_positions[0], ones_positions[1])]

    # Exclude specified positions from the list
    filtered_ones_list = [pos for pos in ones_list if pos not in exclude_positions]

    if not filtered_ones_list:
        return None  # Return None if no positions are left after exclusion

    return random.choice(filtered_ones_list)

def print_colored_matrix_seaborn(matrix: np.matrix, title):
    """
    Displays a matrix using seaborn heatmap
    """
    color_matrix = np.where(matrix != 0, np.where(matrix % 3 == 0, 3, matrix), matrix)
    annot_matrix = matrix  # Matrix to display annotations (original matrix values)

    tiles_types = set(np.unique(color_matrix))

    if len(tiles_types) == 3:
        colors = ["green", "blue", "red"]  # Excludes white if 0 is not present
    else:
        colors = ["white", "green", "blue", "red"]  # Includes white if 0 is present

    cmap = sns.color_palette(colors)
    plt.figure(figsize=(20, 15))
    plt.title(title) 

    sns.heatmap(color_matrix, annot=annot_matrix, cmap=cmap, cbar=False, linewidths=.5,
                linecolor='gray', square=True, fmt="d")
    plt.show()
