#!/usr/bin/env python3
"""
@author : Akshay Upadhya B
Python3
Accuracy got : 79-80%
"""
print("Ensure Python 3 is being used")
import numpy as np
import pandas as pd
df = pd.read_csv('SPECTF_New.csv')
# print(df)
x = df.as_matrix()
y = x[:, -1:]   # outputs
x = x[:, :-1]   # inputs

def return_kfold(k):
    x_train = []
    x_test = []
    y_train = []
    y_test = []
    for i in range(len(x)):
        if i%10 == k:
            x_test.append(x[i])
            y_test.append(y[i])
        else:
            x_train.append(x[i])
            y_train.append(y[i])
    return x_train, x_test, y_train, y_test

def get_exp(x, mean, sd):
    return np.exp(-0.5 * np.power(((x-mean)/sd),2))

def get_mean(arr):
    return sum(arr)/len(arr)

def get_sd(arr):
    mean = get_mean(arr)
    return np.sqrt(sum([np.power((ele-mean), 2) for ele in arr])/(len(arr)-1))

def gaussian(arr, ele):
    mean = get_mean(arr)
    sd = get_sd(arr)
    exp = get_exp(ele, mean, sd)
    return exp/(np.sqrt(2*np.pi)*sd)

# The Naive Bayes classifier used as fitness function
def feature_eval(chromosome):
    overall_accuracy = 0
    true_pos = 0
    false_pos = 0
    false_neg = 0
    for i in range(10):
        arr_yes = []
        arr_no = []
        x_train, x_test, y_train, y_test = return_kfold(i)
        total_yes = 0
        total_no = 0
        for num, y in enumerate(y_train):
            if y == 'Yes':
                arr_yes.append(x_train[num])
                total_yes += 1
            else:
                arr_no.append(x_train[num])
                total_no += 1
        p_yes = total_yes / (total_yes + total_no)
        p_no = 1 - p_yes

        arr_yes = np.array(arr_yes)
        arr_no = np.array(arr_no)
        total_ans = 0

        for test_num, ele in enumerate(x_test):
            yes_prod = 1
            no_prod = 1
            for col_num, col_ele in enumerate(ele):
                if chromosome[col_num] == 1:
                    inter_arr = np.transpose(arr_yes[:, [col_num]])
                    inter_arr = inter_arr.flatten()
                    yes_prod *= gaussian(inter_arr, col_ele)

                    inter_arr = np.transpose(arr_no[:, [col_num]])
                    inter_arr = inter_arr.flatten()
                    no_prod *= gaussian(inter_arr, col_ele)

            yes_prod *= p_yes
            no_prod *= p_no

            if yes_prod > no_prod:
                predict = "Yes"
            else:
                predict = "No"
            if predict == y_test[test_num]:
                total_ans += 1
                if predict == "Yes":
                    true_pos += 1
            elif predict == "Yes":
                false_pos += 1
            else:
                false_neg += 1
        overall_accuracy += (total_ans / len(x_test))
    precison = true_pos / (true_pos + false_pos)
    recall = true_pos / (true_pos + false_neg)
    return (overall_accuracy / 10), precison, recall


def cross_over(chromosome1, chromosome2):
    crossover_len = int(len(chromosome1)/2)
    chromosome1 = ''.join(str(e) for e in chromosome1)
    chromosome2 = ''.join(str(e) for e in chromosome2)
    return [int(_) for _ in list(chromosome1[:crossover_len] + chromosome2[crossover_len:])]

def mutate(chromosome):
    x = np.random.randint(len(chromosome))
    if chromosome[x] == 0:
        chromosome[x] = 1
    else:
        chromosome[x] = 0
    return chromosome


def perform_genetic(chromosome_list):
    np.random.shuffle(chromosome_list)
    for i in range(0, int(25*pop_size/100), 2):  # select the 25% cross overpairwise
        chromosome_1 = chromosome_list[i]
        chromosome_2 = chromosome_list[i + 1]
        crossover_chromosome = cross_over(chromosome_1, chromosome_2)
        eval_chromosome_1 = feature_eval(chromosome_1)[0]
        print("Iteration: " + str(i/2) + "\nEvaluation of chromosome 1\t\t:" + str(eval_chromosome_1))
        eval_chromosome_2 = feature_eval(chromosome_2)[0]
        print("Evaluation of chromosome 2\t\t:" + str(eval_chromosome_2))
        eval_chromosome_cross = feature_eval(crossover_chromosome)[0]
        print("Evaluation of crossover chromosome\t:" + str(eval_chromosome_cross))
        if min(eval_chromosome_1, eval_chromosome_2, eval_chromosome_cross) == eval_chromosome_1:
            chromosome_list[i] = crossover_chromosome
        elif min(eval_chromosome_1, eval_chromosome_2, eval_chromosome_cross) == eval_chromosome_2:
            chromosome_list[i + 1] = crossover_chromosome
    np.random.shuffle(chromosome_list)

    # randomly mutate 10% of the chromosomes
    for i in range(int(10*pop_size/100)):
        chromosome_list[i] = mutate(chromosome_list[i])  # randomly mutate 10 chromosomes
    return chromosome_list


def genetic_algo():
    ch_num = x.shape[1]  # gives the number of columns which is the chromosome length
    chromosome_list = np.array([list(np.random.randint(2, size=ch_num)) for _ in range(pop_size)]) # randomly generate chromosomes
    for i in range(generations):  # genetic algo is applied generation times
        print ("\nGeneration : " + str(i+1) + "\n")
        chromosome_list = perform_genetic(chromosome_list)
    max_score = 0
    print ("\nTesting for best chromosome\n")
    for i in range(chromosome_list.shape[0]):
        eval_score, p, r = feature_eval(chromosome_list[i])
        print ("Chromosome\t" + ''.join(str(_) for _ in list(chromosome_list[i])) + "\tScore\t" + str(eval_score))
        if eval_score > max_score:
            max_score = eval_score
            precison = p
            recall = r
            best_feature_set = chromosome_list[i]
    print(best_feature_set)
    print ("Number of features : ", list(best_feature_set.count(1)))
    print("Accuracy: " + str(max_score)+" Precison: " + str(precison)+" Recall: " + str(recall))

pop_size = 30
generations = 10
genetic_algo()
