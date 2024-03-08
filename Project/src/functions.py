import subprocess
from tokenize import String
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import random
from collections import namedtuple
import os

Position = namedtuple('Position', ['x','y'])


def extract_plan_details_0(output):
    # Inizia a raccogliere le righe del piano dopo la riga che contiene "; Plan found with metric"
    lines = output.split('\n')
    plan_start = False
    plan_lines = []

    for line in lines:
        if ";;;; Solution Found" in line and plan_start:
            plan_lines.pop()
            break
        if "; Plan found with metric" in line or plan_start:
            plan_start = True
            plan_lines.append(line)


    return "\n".join(plan_lines)

def extract_plan_details_1(output):
    # Inizia a raccogliere le righe del piano dopo la linea che contiene ";;;; Solution Found"
    lines = output.split('\n')
    plan_start = False
    plan_lines = []

    for line in lines:
        if ";;;; Solution Found" in line:
            plan_start = True
            plan_lines.append(";;;; Solution Found")
            continue
        if plan_start:
            plan_lines.append(line)

    return "\n".join(plan_lines)
def request_plan(env_folder, planner, args, lang = 'pddl'):

    domain_path = f'{env_folder}/domain.{lang}'
    problem_path = f'{env_folder}/problem.{lang}'
    output_plan_path = f'{env_folder}/{planner}_plan.{lang}'  # Percorso del file di piano rinominato

    # Costruisci il comando per eseguire il planner
    command = ''

    if planner == 'optic':
        command = f'planutils run {planner} -- {args} {domain_path} {problem_path}'

    elif planner == 'dual-bfws-ffparser':
        command = f'planutils run {planner} -- {domain_path} {problem_path} -- {args}'

    elif planner == 'panda':
        command = f'java -jar ./src/PANDA.jar {args} {domain_path} {problem_path}'

    elif planner == 'lama-first':
        command = f'planutils run {planner} -- {args} {domain_path} {problem_path}'

    elif planner == 'ff':
        command = f'planutils run {planner} {domain_path} {problem_path}'

    elif planner == 'tfd':
        command = f'planutils run {planner} {domain_path} {problem_path}'


    print(f' - Command: {command}')
    result = subprocess.run(command, capture_output=True, text=True, shell=True)


    if planner == 'optic' and not env_folder.startswith('task_problems/problem_4'):
        plan_details = extract_plan_details_0(result.stdout)

        if ";;;; Solution Found" in plan_details:
            with open(output_plan_path, 'w') as f:
                f.write(plan_details)
            print(f" -> Plan found, saved at: {output_plan_path}")
        else:

            print(" -> No plan found")

    elif planner == 'optic' and env_folder.startswith('task_problems/problem_4'):
        plan_details = extract_plan_details_1(result.stdout)

        if ";;;; Solution Found" in plan_details:
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

    elif planner == 'ff':
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


def extract_plan_details_2(output):
    # Inizia a raccogliere le righe del piano dopo la linea che contiene ";;;; Solution Found"
    lines = output.split('\n')
    plan_start = False
    plan_lines = []

    for line in lines:
        if "New solution has been found." in line:
            plan_start = True
            continue
        if plan_start:
            plan_lines.append(line)

    return "\n".join(plan_lines)

def select_random_one_position(matrix, exclude_positions=[]):
    # Trova le posizioni dei valori impostati ad 1
    ones_positions = np.where(np.logical_or(matrix == 1, matrix == 3))
    ones_list = [Position(x,y) for (x,y) in zip(ones_positions[0], ones_positions[1])] # Crea una lista di tuple (x, y)

    # Filtra la lista di posizioni escludendo quelle nella lista di esclusione
    filtered_ones_list = [pos for pos in ones_list if pos not in exclude_positions]

    if not filtered_ones_list:
        return None  # Restituisce None se non ci sono posizioni valide dopo l'esclusione

    # Seleziona una posizione casuale tra quelle rimanenti
    return random.choice(filtered_ones_list)



def print_colored_matrix_seaborn(matrix : np.matrix, title):
    # Definizione della palette di colori: uno per ogni valore unico nella matrice
    # 0: bianco, 1: verde, 2: blu, 3: rosso
    tiles_types = set()
    color_matrix = np.where(matrix != 0, np.where(matrix % 3 == 0, 3, matrix), matrix)
    annot_matrix = matrix

    for x in range(color_matrix.shape[0]):
        for y in range(color_matrix.shape[1]):
            tiles_types.add(color_matrix[x][y])

    if len(tiles_types) == 3:
        colors = ["green", "blue", "red"]
    else:
        colors = ["white","green", "blue", "red"]

    # Crea un colormap personalizzato da una lista di colori
    cmap = sns.color_palette(colors)
    plt.figure(figsize=(20, 15))
    plt.title(title)
    
    # Crea una mappa di calore con Seaborn
    sns.heatmap(color_matrix, annot=annot_matrix, cmap=cmap, cbar=False, linewidths=.5,
                linecolor='gray', square=True, fmt="d")
    plt.show()

