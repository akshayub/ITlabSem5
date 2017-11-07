import numpy as np
import pandas as pd
df = pd.read_csv('SPECTF_New.csv')
print(df)
x = df.as_matrix()
y = x[:, -1:]
x = x[:, :-1]


# this is used to return the x_train, x_test, y_train and y_test which are returned to the function calling it
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


# this is used to calculate e^(-1/2((x-mew)/sigma)^2) part. It takes as input x, mew(mean) and sigma(sd)
def get_exp(x, mean, sd):
    return np.exp(-0.5 * np.power(((x-mean)/sd),2))


# returns the mean of the list.Here list is passes as arr
def get_mean(arr):
    return sum(arr)/len(arr)


# returns the standard deviation of the list. Here list is passed as arr
def get_sd(arr):
    mean = get_mean(arr)
    return np.sqrt(sum(np.power((ele-mean), 2) for ele in arr)/(len(arr)-1))


# Here I calculate the entire gaussian expression, i.e (1/(root(2)*pi))*(e^-1/2((x-mew/sigma)^2))
def gaussian(arr, ele):
    mean = get_mean(arr)
    sd = get_sd(arr)
    exp = get_exp(ele, mean, sd)
    return exp/(np.sqrt(2*np.pi)*sd)

def feature_eval(chrome):
    # the naive bayes is exactly same as above exact for in this we check if a feature has to be included or not.
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
        # Now we have the arrays having values corresponding to yes and no
        for num, y in enumerate(y_train):
            if y == 'Yes':
                arr_yes.append(x_train[num])
                total_yes += 1
            else:
                arr_no.append(x_train[num])
                total_no += 1
        p_yes = total_yes / (total_yes + total_no)
        p_no = 1 - p_yes
        # print(p_yes, p_no)
        arr_yes = np.array(arr_yes)
        arr_no = np.array(arr_no)
        total_ans = 0
        for test_num, ele in enumerate(x_test):
            yes_prod = 1
            no_prod = 1
            for col_num, col_ele in enumerate(ele):
                if chrome[col_num] == 1:  # if chrome[col_num] == 1 this means that the particular feature has to be included
                    # only if the feature has to be included i.e the chromosome value is 1, we multiply the probability of yes/no given that feature
                    inter_arr = np.transpose(arr_yes[:, [col_num]])
                    inter_arr = inter_arr.flatten()
                    yes_prod *= gaussian(inter_arr, col_ele)
                    # all these are same as the traditional naive bayes
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


def cross_over(chrome1, chrome2):
    x = []
    crossover_len = int(len(chrome1)/2)
    chrome1 = ''.join(str(e) for e in chrome1)  # we make chromosome from a list to into a string so that string can be split
    chrome2 = ''.join(str(e) for e in chrome2)
    x = chrome1[:crossover_len] + chrome2[crossover_len:]
    return [int(_) for _ in list(x)]  # we return the crossed over chromosome


def mutate(chrome):
    x = np.random.randint(len(chrome))  # we select a random integer and the bits are flipped
    if chrome[x] == 0:
        chrome[x] = 1
    else:
        chrome[x] = 0
    return chrome


def perform_genetic(ch_matrix):
    # 1 crosses over with 2, 3 with that of 4 and soon upto 25 and 26.
    np.random.shuffle(ch_matrix)  # shuffle the chromosome
    for i in range(0, int(25*pop_size/100), 2):  # select the 25% cross overpairwise
        chrome_1 = ch_matrix[i]
        chrome_2 = ch_matrix[i + 1]
        crossover_chrome = cross_over(chrome_1, chrome_2)
        eval_chrome_1 = feature_eval(chrome_1)[0]
        eval_chrome_2 = feature_eval(chrome_2)[0]
        print("Iteration: " + str(i/2) + "\nEvaluation of chrome 1: " + str(eval_chrome_1))
        print("Evaluation of chrome 2: " + str(eval_chrome_2))
        eval_chrome_cross = feature_eval(crossover_chrome)[0]
        print("Evaluation of crossover chrome : " + str(eval_chrome_cross))
        if min(eval_chrome_1, eval_chrome_2, eval_chrome_cross) == eval_chrome_1:  # if parent chromosome 1 has a lower evaluation percentage, replace it with the crossed over chromosome
            ch_matrix[i] = crossover_chrome
        elif min(eval_chrome_1, eval_chrome_2, eval_chrome_cross) == eval_chrome_2:  # if parent chromsom 2 has a lower eval rate, replace that with crossed over chromosome
            ch_matrix[i + 1] = crossover_chrome
    np.random.shuffle(ch_matrix)

    # Here we randomly mutate 10% of the chromosomes
    for i in range(int(10*pop_size/100)):
        ch_matrix[i] = mutate(ch_matrix[i])  # randomly mutate 10 chromosomes
    return ch_matrix


def genetic_algo():
    ch_num = x.shape[1]  # gives the number of columns which is the chromosome length
    ch_matrix = np.array([list(np.random.randint(2, size=ch_num)) for _ in range(pop_size)])    # here we randomly generate chromosomes
    for i in range(generations):  # genetic algo is applied generation times
        ch_matrix = perform_genetic(ch_matrix)  # we perform genetic algo on the chromsome matrix
    max_score = 0
    for i in range(ch_matrix.shape[0]):
        eval_score, p, r = feature_eval(ch_matrix[i])
        if eval_score > max_score:
            max_score = eval_score
            precison = p
            recall = r
            best_feature_set = ch_matrix[i]  # here we determine the best chromosomes among all the chromosomes
    print(best_feature_set)  # print the chromosome giving best eval rate
    print("Accuracy: " + str(max_score)+" Precison: " + str(precison)+" Recall: " + str(recall))

pop_size = 30
generations = 10
genetic_algo()
