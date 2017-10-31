"""
@author: Akshay Upadhya B, 15IT204
"""

import numpy as np
import pandas as pd

def initiate_centers():
    a = int(np.random.random()*X.shape[0])
    b = int(np.random.random()*X.shape[0])
    while(b==a):
        b = int(np.random.random()*X.shape[0])
    return X[a], X[b]

def get_clusters(c1, c2):
    degree1 = []
    degree2 = []
    c1 = np.array(c1).reshape(c1.shape[0], 1)
    c2 = np.array(c2).reshape(c2.shape[0], 1)
    for i in range(X.shape[0]):
        temp = np.array(X[i]).reshape(X[i].shape[0], 1)
        dist1 = np.linalg.norm(temp-c1)
        dist2 = np.linalg.norm(temp-c2)
        if np.array_equal(temp,c1):
            degree1.append(1)
            degree2.append(0)
        elif np.array_equal(temp,c2):
            degree1.append(0)
            degree2.append(1)
        else:
            dist1 = np.linalg.norm(temp-c1)
            dist2 = np.linalg.norm(temp-c2)
            ans = 1/(1+np.square(dist1/dist2))
            degree1.append(ans)
            degree2.append(1-ans)
    degree1 = np.array(degree1)
    degree2 = np.array(degree2)
    return degree1, degree2

def find_center(degree1, degree2, c1, c2):
    degree1 = np.square(degree1).reshape(degree1.shape[0], 1)
    degree2 = np.square(degree2).reshape(degree2.shape[0], 1)
    avg1 = np.sum(np.multiply(degree1, X), axis=0)/np.sum(degree1)
    avg2 = np.sum(np.multiply(degree2, X), axis=0)/np.sum(degree2)
    return avg1, avg2


def c_means():
    c1, c2 = initiate_centers()
    print ("Initial Clusters\n",c1,'\n\n',c2,'\n')

    for i in range(20):
        degree1, degree2 = get_clusters(c1, c2)
        c1, c2 = find_center(degree1, degree2, c1, c2)

    print ("Final Clusters\n",c1,'\n\n',c2,'\n')

    yes1 = 0
    yes2 = 0
    no1 = 0
    no2 = 0
    for i in range(degree1.shape[0]):
        if degree1[i] > degree2[i]:
            if y[i] == "Yes":
                yes1 += 1
            else:
                no1 += 1
        else:
            if y[i] == "Yes":
                yes2 += 1
            else:
                no2 += 1
    print ("Cluster 1 : Yes = {} No = {}".format(yes1, no1))
    print ("Cluster 2 : Yes = {} No = {}".format(yes2, no2))
    print("Accuracy:",max(yes1+no2, yes2+no1)/X.shape[0])

if __name__ == '__main__':
    df = pd.read_csv('SPECTF_New.csv')
    X = df.as_matrix()
    y = np.array(X[:,[-1]])
    X = np.array(X[:,:-1])
    c_means()
