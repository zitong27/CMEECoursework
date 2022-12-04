#!/usr/bin/env python3

"""Data cleaning and preparing"""

import pandas as pd
import numpy as np

data = pd.read_csv("../data/LogisticGrowthData.csv")
data.head()
len(data)
data.insert(0, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)
data.drop(data[data["Time"] <= 0].index, inplace=True)
data.drop(data[data["PopBio"] <= 0].index, inplace=True)
data.insert(4,"log_PopBio",np.log(data.PopBio))

ids=range(1,len(data.ID.unique())+1)
for i in range(0,len(data.ID.unique())):
    data["ID"]=data.ID.replace(to_replace = data.ID.unique()[i],value=ids[i])




data.to_csv("../data/IDData.csv")

