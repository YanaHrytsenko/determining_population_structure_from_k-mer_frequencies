import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from os import listdir
from os.path import isfile, join
import pickle

'''
Modules used:
module load matplotlib/3.3.3-intel-2020b
module load SciPy-bundle/2020.11-intel-2020b
module load scikit-learn/0.23.2-intel-2020b
'''

pickled_dictionary_filtered = 'k_21_WGS_5_populations_intersection_across.p'

kmer_frequencies_dictionary = pickle.load( open( pickled_dictionary_filtered, "rb" ) )


df = pd.DataFrame(kmer_frequencies_dictionary)

population = ['AFR_LWK', 'AFR_LWK', 'AFR_LWK', 'AFR_LWK', 'AFR_LWK', 'AFR_LWK',
              'AMR_PEL', 'AMR_PEL', 'AMR_PEL', 'AMR_PEL', 'AMR_PEL', 'AMR_PEL',
              'EAS_JPT', 'EAS_JPT', 'EAS_JPT', 'EAS_JPT', 'EAS_JPT', 'EAS_JPT',
              'EUR_TSI', 'EUR_TSI', 'EUR_TSI', 'EUR_TSI', 'EUR_TSI', 'EUR_TSI',
              'SAS_ITU', 'SAS_ITU', 'SAS_ITU', 'SAS_ITU', 'SAS_ITU', 'SAS_ITU']

df['Population'] = population

features = df.columns.tolist()[0:-1] #['AAAAAAAAAAAAAAAAAAAAA', ... , 'TTTTTTTTTTCAAAAAAAAAA']

x = df.loc[:, features].values
y = df.loc[:,['Population']].values
std_x = StandardScaler().fit_transform(x)


pca = PCA(n_components = 30) #use num samples
principalComponents = pca.fit_transform(std_x)


def get_num_pcs(expl_var):
    list_of_var_vals = list(expl_var)
    cum_val = 0.0
    num_PCs = 0
    for i in list_of_var_vals:
            percnt = float(i) * 100
            cum_val += percnt
            if(cum_val >= 80.0):
                num_PCs = int(list_of_var_vals.index(i)) + 1
                break;
    return (cum_val, num_PCs)


cum_val, num_PCs = get_num_pcs(pca.explained_variance_ratio_) #this tells us how many PCs are needed for >= 80% of the variance

print(cum_val, num_PCs) #double check that its about 80% and 21 PCs

list_of_column_headers = [] #for dataframe

for i in range(1, pca.n_components_+1, 1):
    col_label = 'principal component ' + str(i)
    list_of_column_headers.append(col_label)

principalDf = pd.DataFrame(data = principalComponents, columns = list_of_column_headers) #['principal component 1', 'principal component 2', 'principal component 3', 'principal component 4', 'principal component 5']

finalDf = pd.concat([principalDf, df[['Population']]], axis = 1) #add a column with populations


#Visualize 2D Projection
fig = plt.figure(figsize = (8,8))
ax = fig.add_subplot(1,1,1)
ax.set_xlabel('Principal Component 1', fontsize = 15)
ax.set_ylabel('Principal Component 2', fontsize = 15)

targets = ['AFR_LWK', 'AMR_PEL', 'EAS_JPT', 'EUR_TSI', 'SAS_ITU'] #make sure they are listed in the correct order
colors = ['m', 'r', 'g', 'b', 'y'] #['b', 'g', 'r', 'c', 'm', 'y', 'k', 'w']
for target, color in zip(targets,colors):
    indicesToKeep = finalDf['Population'] == target
    ax.scatter(finalDf.loc[indicesToKeep, 'principal component 1']
               , finalDf.loc[indicesToKeep, 'principal component 2']
               , c = color
               , s = 50)
ax.legend(targets)
ax.grid()
plt.savefig("2D_PCA_5_pops_80_prcn_variance.pdf")
plt.clf() #clear the plt variable so the plots don't overlap


#Clustering with K-means
inertias = []
ks = range(1, 10)
# Creating 10 K-Mean models while varying the number of clusters (k)
for k in range(1,10):
    model = KMeans(n_clusters=k)

    # Fit model to samples
    model.fit(finalDf.iloc[:,:num_PCs])#use the number of PCs that give 80% of variance

    # Append the inertia to the list of inertias
    inertias.append(model.inertia_)

plt.plot(range(1,10), inertias, '-p', color='gold')
plt.xlabel('number of clusters, k')
plt.ylabel('inertia')
plt.xticks(ks)
plt.savefig("elbow_method_plot_5_pops_80_prcnt_variance.pdf")
plt.clf() #clear the plt variable so the plots don't overlap

model = KMeans(n_clusters=3)#double check that it actually is three from the elbow plot

model.fit(finalDf.iloc[:,:num_PCs]) #build a model from the number of PCs that hold 80% of the variance

labels = model.predict(finalDf.iloc[:,:num_PCs])

plt.scatter(finalDf['principal component 1'], finalDf['principal component 2'], c=labels) #from the model trained on 80% plot the first 2PCs
plt.xlabel('PC1', fontsize = 15)
plt.ylabel('PC2', fontsize = 15)
plt.savefig("k_means_clustering_5_pops_21_mers_param_80_prcnt_variance.pdf")
plt.clf() #clear the plt variable so the plots don't overlap
