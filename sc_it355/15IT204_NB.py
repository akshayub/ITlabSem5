#!/usr/bin/env python3
"""
@author : Akshay Upadhya B
Python3
Accuracy got : 73%
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

def naive_bayes_classifier():
    overall_accuracy = 0
    true_positive = 0
    false_positive = 0
    false_negative = 0

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
            # print(ele)
            for col_num, col_ele in enumerate(ele):
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
                    true_positive += 1
            elif predict == "Yes":
                false_positive += 1
            else:
                false_negative += 1

        print("Iteration: " + str(i + 1) + " Accuracy: " + str(total_ans / len(x_test)))
        overall_accuracy += (total_ans / len(x_test))
    precision = true_positive / (true_positive + false_positive)
    recall = true_positive / (true_positive + false_negative)
    print(
        "Overall Accuracy: " + str(overall_accuracy / 10) + " Precison: " + str(precision) + " Recall: " + str(recall))

if __name__ == '__main__':
    naive_bayes_classifier()
