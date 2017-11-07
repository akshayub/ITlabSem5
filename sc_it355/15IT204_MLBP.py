"""

@author :   Akshay Upadhya B
@id     :   15IT204

"""
# coding: utf-8

# In[1]:

import pandas as pd
import numpy as np

classes = {}


# In[2]:

# Loading the database and also assigning the classes a variable
def load(filename):
    r = pd.read_csv(filename)
    data = np.asarray(r)
    np.random.shuffle(data)
    class_label = set(data[:,-1])
    for i,x in enumerate(list(class_label)):
        classes[x] = i
        
    for row in data:
        row[-1] = classes[row[-1]]
    
    return data


# In[3]:

def split(data, foldNum):
    train = []
    test = []

    for i,x in enumerate(data):
        if i%10 == foldNum:
            test.append(x)
        else:
            train.append(x)

    return np.asarray(train), np.asarray(test)


# In[4]:

def sigmoid(x):
    return 1.0 / (1 + np.exp(-x))


# In[5]:

def training(lr, train_data, bias_hidden, bias_output, weight_ip_hd, weight_hd_op, iters=500):
    for y in range(iters):
        error_hd = []
        for row in train_data:
            # First find the dot product of each row of the weight with the input.
            layer_1 = np.array(np.sum(row[:-1] * weight_ip_hd, axis=1) + bias_hidden, dtype=np.float64)
            layer_1 = np.apply_along_axis(sigmoid,0,layer_1)
            sig_vals = np.copy(layer_1)
            # Now for the final layer
            val_op = np.dot(layer_1,weight_hd_op) + bias_output
            output = sigmoid(val_op)
            # Now get the actual output for the row
            actual_output = row[-1]
            output_error = output * (1 - output) * (actual_output - output)
            bias_output = bias_output + (lr * output_error)
            # Backprop
            error_hd = np.multiply(np.multiply(sig_vals, (1 - sig_vals)), (weight_hd_op * output_error))
            weight_hd_op = weight_hd_op + (lr * sig_vals * output_error)
            bias_hidden = bias_hidden + (lr * error_hd)
            
            # Finished with one, another one begins
            error_hd = error_hd.reshape(1,len(bias_hidden))
            weight_ip_hd = weight_ip_hd + (lr * (error_hd.T * row[:-1]))

    return np.asarray(weight_ip_hd), np.asarray(weight_hd_op), np.asarray(bias_hidden), np.asarray(bias_output)
            


# In[6]:

def testing(test_data, bias_hidden, bias_output, weight_ip_hd, weight_hd_op, threshold):
    tp = tn = fp = fn = 0.0
    for row in test_data:
        layer_1 = np.array(np.sum(row[:-1] * weight_ip_hd, axis=1) + bias_hidden, dtype=np.float64)
        layer_1 = np.apply_along_axis(sigmoid,0,layer_1)
        # Now for the final layer
        val_op = np.dot(layer_1,weight_hd_op) + bias_output
        output = sigmoid(val_op)
        
        if output >= threshold:
            pred_output = 1
        else:
            pred_output = 0
        
        actual_output = row[-1]
        
        print pred_output, actual_output, output
        
        if (pred_output == actual_output):
            if pred_output == 1.0:
                tp += 1
            else:
                tn += 1
        else:
            if pred_output == 1.0:
                fp += 1
            else:
                fn += 1

    return tp, tn, fp, fn


# In[7]:

data = load('IRIS.csv')
# Variables
print classes
features = len(data[0]) - 1
data_size = len(data)
learning_rate = 0.1
hidden_layer_nodes = 5
threshold = 0.65

bias_at_hidden = 5
bias_at_output = 1
bias_hidden = np.array([bias_at_hidden] * hidden_layer_nodes)

wt_ip_hd = [[1.0/(features * hidden_layer_nodes + bias_at_hidden)] * features] * hidden_layer_nodes
wt_ip_hd = np.asarray(wt_ip_hd)

wt_hd_op = [1.0/(hidden_layer_nodes + bias_at_hidden)] * hidden_layer_nodes
wt_hd_op = np.asarray(wt_hd_op)

#Split the training and testing
accuracy = precision = recall = 0
for i in range(10): #1 folds
    train, test = split(data, i)
    
    wt_ip_hd, wt_hd_op, bias_hidden, bias_at_output = training(
        learning_rate,
        train,
        bias_hidden,
        bias_at_output,
        wt_ip_hd,
        wt_hd_op,
        iters=500
    )
    
    tp, tn, fp, fn = testing(test, bias_hidden, bias_at_output, wt_ip_hd, wt_hd_op, threshold)
    try:
        pre = tp / (tp + fp)
    except ZeroDivisionError:
        pre = 0
    try:
        rec = tp / (tp + fn)
    except ZeroDivisionError:
        rec = 0
        
    acc = (tp + tn) / (tp + tn + fp + fn)
    print acc, pre, rec
    
    accuracy += acc
    precision += pre
    recall += rec
    
accuracy /= 10
precision /= 10
recall /= 10

print "Accuracy = {}, Precision = {}, Recall = {}".format(accuracy, precision, recall)

