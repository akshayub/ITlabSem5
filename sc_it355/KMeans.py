"""
@author: Akshay Upadhya B, 15IT204
"""

import numpy as np
import pandas as pd

def initiate_centers():
    a = int(np.random.random()*X.shape[0])
    b = int(np.random.random()*X.shape[0])
    while(a==b):
        b = int(np.random.random()*X.shape[0])
    return np.array(X[a]), np.array(X[b])

def calculate_avg(c1, c2):
    c1 = np.array(c1)
    c2 = np.array(c2)
    avg1 = np.sum(c1, axis=0)/c1.shape[0]
    avg2 = np.sum(c2, axis=0)/c2.shape[0]
    return avg1, avg2

def make_clusters(c1, c2):
    cluster1 = []
    cluster2 = []
    y_cluster1 = []
    y_cluster2 = []
    for i in range(X.shape[0]):
        dist1 = np.linalg.norm(X[i]-c1)
        dist2 = np.linalg.norm(X[i]-c2)
        if dist1<dist2:
            cluster1.append(X[i])
            y_cluster1.append(y[i])
        else:
            cluster2.append(X[i])
            y_cluster2.append(y[i])
    cluster1 = np.array(cluster1)
    cluster2 = np.array(cluster2)
    y_cluster1 = np.array(y_cluster1)
    y_cluster2 = np.array(y_cluster2)
    return cluster1, cluster2, y_cluster1, y_cluster2

def k_means():
    c1, c2 = initiate_centers()
    print ("Initial Clusters\n",c1,'\n\n',c2,'\n')

    for i in range(10):
        cluster1, cluster2, y_cluster1, y_cluster2 = make_clusters(c1, c2)
        c1, c2 = calculate_avg(cluster1, cluster2)

    print ("Final Clusters\n",c1,'\n\n',c2,'\n')

    yes1 = 0
    no1 = 0
    yes2 = 0
    no2 = 0
    for each in y_cluster1:
        if each == "Yes":
            yes1+=1
        else:
            no1+=1
    for each in y_cluster2:
        if each == "Yes":
            yes2+=1
        else:
            no2+=1
    print ("Cluster 1 : Yes = {} No = {}".format(yes1, no1))
    print ("Cluster 2 : Yes = {} No = {}".format(yes2, no2))
    print("Accuracy:",max(yes1+no2, yes2+no1)/X.shape[0])

if __name__ == '__main__':
    df = pd.read_csv("SPECTF_New.csv")
    X = df.as_matrix()

    y = X[:, [-1]]
    y = np.array(y)
    X = X[:,:-1]
    X = np.array(X)

    k_means()
