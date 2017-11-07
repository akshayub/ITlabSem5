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


def naive_bayes_classifier():
    overall_accuracy = 0
    true_positive = 0
    false_positive = 0
    false_negative = 0
    for i in range(10):
        arr_yes = []
        arr_no = []
        x_train, x_test, y_train, y_test = return_kfold(i)  # here i get the x_train, x_test etc
        total_yes = 0
        total_no = 0
        # Now we have the arrays having values corresponding to yes and no
        for num, y in enumerate(y_train):  # here I enumerate the training data set to determine which X has a "yes" and which has a "No"
            if y == 'Yes':
                arr_yes.append(x_train[num])  # since num in y_train corresponds to same index as that in x_train, to get the corresponding x_train value, I use x_train[num]
                total_yes += 1
            else:
                arr_no.append(x_train[num])  # So I am storing training data  corresponding to "yes" and "no" in two seperate arays i.e arr_yes and arr_no
                total_no += 1
        p_yes = total_yes / (total_yes + total_no)  # we calculate the probability of a yes
        p_no = 1 - p_yes  # we calculate the probability of a no
        # print(p_yes, p_no)
        arr_yes = np.array(arr_yes)  # converting the array into a numpy array
        arr_no = np.array(arr_no)
        total_ans = 0
        for test_num, ele in enumerate(x_test):
            yes_prod = 1
            no_prod = 1
            # print(ele)
            for col_num, col_ele in enumerate(ele):  # here col_num is index of the feature in the test data and col_ele is the value of the feature
                # this is done for all the features, so the for loop
                inter_arr = np.transpose(arr_yes[:, [col_num]])  # here we get set of all features for that particular index for which the output value is a "yes"
                inter_arr = inter_arr.flatten()  # we store all features
                yes_prod *= gaussian(inter_arr, col_ele)  # we calculate the probability that it is yes given that feature

                inter_arr = np.transpose(arr_no[:, [col_num]])  # similar like how we do for a yes
                inter_arr = inter_arr.flatten()
                no_prod *= gaussian(inter_arr, col_ele)

            yes_prod *= p_yes  # here we calculate the probability of a yes
            no_prod *= p_no  # here we calculate the probability of a no

            if yes_prod > no_prod:  # if product of yes is more that means the data set is expected to give "yes"
                predict = "Yes"
            else:
                predict = "No"
            if predict == y_test[test_num]:  # here the normal acuracy checking steps
                total_ans += 1
                if predict == "Yes":
                    true_positive += 1
            elif predict == "Yes":
                false_positive += 1
            else:
                false_negative += 1
                # print(predict, y_test[test_num])
        print("Iteration: " + str(i + 1) + " Accuracy: " + str(total_ans / len(x_test)))
        overall_accuracy += (total_ans / len(x_test))
    precision = true_positive / (true_positive + false_positive)
    recall = true_positive / (true_positive + false_negative)
    print(
        "Overall Accuracy: " + str(overall_accuracy / 10) + " Precison: " + str(precision) + " Recall: " + str(recall))


naive_bayes_classifier()  # running the naive bayes classifier

