"""

@author :   Akshay Upadhya B
@id     :   15IT204

"""
# coding: utf-8

# In[1]:

import numpy as np
import pandas as pd


# In[2]:

# filename = 'datasets/IRIS.csv'
# filename = 'datasets/SPECTF_New.csv'


# In[3]:

def load_data(filename):
    data = np.asarray(pd.read_csv(filename))
    classes = set()
    for _ in data:
        classes.add(_[-1])
    classes = dict(zip(classes, range(len(classes))))
    np.random.shuffle(data)
    return (data, classes)


# In[4]:

def splitDataset(data, fold, test_data_size):
    testStart = eachFold*test_data_size
    testEnd = (eachFold+1)*test_data_size
    
    test = data[testStart:testEnd]
    train = np.concatenate((data[:testStart], data[testEnd:]), axis = 0)
    
    return np.asarray(train), np.asarray(test)


# In[5]:

def train(data, lr, weights, bias, classes, shouldBiasChange, iters=1):
    for ___ in xrange(iters):
        for each in data:
            predicted_val = np.dot(each[:-1], weights) + bias
#             print predicted_val, each[:-1], weights
            predicted_val = int(np.clip(np.sign(predicted_val),0,1))
            actual_val = classes[each[-1]]
#             print predicted_val, '\t',actual_val
            error = predicted_val - actual_val
            delW = lr * error * each[:-1]
#             print error, delW
            weights = weights - delW
            if shouldBiasChange:
                bias = bias - lr*error
    return weights, bias


# In[6]:

def test(data, weights, bias, classes):
    tp = tn = fp = fn = 0
    
    for each in data:
        predicted_val = np.dot(each[:-1], weights) + bias
        predicted_val = int(np.clip(np.sign(predicted_val),0,1))

        if (predicted_val == classes[each[-1]]):
            if predicted_val == 1:
                tp += 1
            else:
                tn += 1
        else:
            if predicted_val == 1:
                fp += 1
            else:
                fn += 1
    
    accuracy = (tp + tn)*100/(tp + tn + fp + fn)
    try:
        precision = (tp)*100/(tp + fp)
    except ZeroDivisionError:
        precision = 0
    try:
        recall = (tp)*100/(tp + fn)
    except ZeroDivisionError:
        recall = 0
    return (accuracy, precision, recall)


# In[21]:

### Parameters

bias = 1.0
shouldBiasChange = False
learning_rate = 0.1
times_with_different_lrs = 10
training_iterations = 100
number_of_folds = 10


# In[22]:

data, classes = load_data(filename)
lr = learning_rate
test_data_size = len(data)/number_of_folds

features = data.shape[1] - 1
# weights = np.random.rand(features)
weights = np.asarray([1.0/(features+1)]*features)

maxAccuracy = -float('inf')
maxAccuracyLr = 0

for _ in range(times_with_different_lrs):
    totalAccuracy = totalPrecision = totalRecall = 0
    
    print 'For learning rate %.1lf\n' %lr
    weights = np.asarray([1.0/(features+1)]*features)
    
    for eachFold in range(number_of_folds):
        trainSet, testSet = splitDataset(data, eachFold, test_data_size)
        weights, bias = train(trainSet, lr, weights, bias, classes, shouldBiasChange, training_iterations)
        accuracy, precision, recall = test(testSet, weights, bias, classes)
        
        print 'Fold %d\tAccuracy : %lf\tPrecision : %lf\tRecall : %lf' %(eachFold+1, accuracy, precision, recall)

        totalAccuracy += accuracy
        totalPrecision += precision
        totalRecall += recall
    
    totalAccuracy /= float(number_of_folds)
    totalPrecision /= float(number_of_folds)
    totalRecall /= float(number_of_folds)
    
    print """
Accuracy : %lf\tPrecision : %lf\tRecall : %lf
    """ %(totalAccuracy, totalPrecision, totalRecall)
    
    if totalAccuracy > maxAccuracy:
        maxAccuracy = totalAccuracy
        maxAccuracyLr = lr
    lr += 0.1
    print '='*100
print 'Max Accuracy is %lf for learning rate %0.1lf' %(maxAccuracy, maxAccuracyLr)


