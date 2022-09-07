import random
import numpy as np
import pandas as pd
import math
import matplotlib.pyplot as plt
import os
import keras
import glob
from sklearn.preprocessing import MinMaxScaler

def load_dataset():

    files=glob.glob("Population/*.xlsx",recursive=True)
    population=[]
    for i in range(0, len(files)):
        parent=pd.read_excel(files[i],header=None).values
        population.append(parent)
    population=np.array(population,dtype=object)

    all_geometry = []
    all_results = []
    for i in range(0, population.shape[0]):
        pop = pd.DataFrame(population[i])
        pop = pop.drop(index=[20, 21], axis=0)
        geometry = pop.iloc[14:22, 1:4].values
        results = pop.iloc[82:96, 2:6].values
        all_geometry.append(geometry)
        all_results.append(results)
    all_geometry = np.array(all_geometry)
    all_results = np.array(all_results)

    return all_geometry,all_results

def fitness_function(pop,val):
    fitness=[0]*pop.shape[0]

    for i in range(pop.shape[0]):
        
        if (val[i][0][0][0]>=-2 and val[i][0][0][0]<=2) and (val[i][1][0][0]>=-2 and val[i][1][0][0]<=2):
            camber_fitness=2*(5-(abs(val[i][1][0][0]-val[i][0][0][0])))
            fitness[i]+=camber_fitness
        else:
            fitness[i]=0
            continue
            
        if (val[i][0][0][1]>=-1 and val[i][0][0][1]<=1) and (val[i][1][0][1]>=-1 and val[i][1][0][1]<=1):
            toe_fitness=3*(4-abs(val[i][1][0][1]-val[i][0][0][1]))
            fitness[i]+=toe_fitness
        else:
            fitness[i]=0
            continue
        
        if (val[i][0][0][2]>=4 and val[i][0][0][2]<=9) and (val[i][1][0][2]>=4 and val[i][1][0][2]<=9):
            fitness[i]+=0.5
        else:
            fitness[i]=0
            continue
            
        if (val[i][0][0][3]>=3 and val[i][0][0][3]<=8) and (val[i][1][0][3]>=3 and val[i][1][0][3]<=8):
            fitness[i]+=0.5
        else:
            fitness[i]=0
            continue

    return fitness

def roulette_selection(population,no_parents,fitness):
    # Roulette_wheel_selection 
    previous_prob=0
    prob_sel=[x/(sum(fitness)+1e-4) for x in fitness]
    prob=[]
    parents=np.empty([no_parents,population.shape[1],population.shape[2]])
    for i in range(len(prob_sel)):
        previous_prob=previous_prob+prob_sel[i]
        prob.append(previous_prob)
    
    for i in range(no_parents):
        n=random.random()
        for j in range(len(prob)):
            if n<prob[j]:
                parents[i]=population[j]
                break
        
    return parents

def crossover(parent,no_offspring,alpha):
    
    offspring=np.empty([no_offspring,parent.shape[1],parent.shape[2]])
    
    for i in range(no_offspring):
        parent1_index=i%parent.shape[0]
        parent2_index=(i+1)%parent.shape[0]
        n=random.random()
        offspring[i]=n*parent[parent1_index]+(1-n)*parent[parent2_index]
        
    return offspring

def mutation(offspring,mutation_rate):
    
    mutation=np.array(offspring,copy=True)
        
    for k in range(offspring.shape[0]):
        m=random.random()
        if m>mutation_rate:
            continue
            
        for j in range(offspring.shape[1]):
            for i in range(offspring.shape[2]):
                sign=random.randint(0,1)
                if sign==0:
                    mutation[k][j][i]=mutation[k][j][i]+random.random()
                else:
                    mutation[k][j][i]=mutation[k][j][i]-random.random()

    
    return mutation

def optimization(pop,no_generation,no_parent,mutation_rate,model):
    bump_val=[200,-60]
    for m in range(no_generation):
        X_flat=pop.reshape((pop.shape[0], -1))
        X=[]
        X_final=[]
        bump_val=[200,-60]
        
        for i in range(X_flat.shape[0]):
            for j in range(len(bump_val)):
                X.append(list(np.append(X_flat[i],bump_val[j])))
            #X_final.append(X)
            #X=[]
            
        X_final=np.array(X)
        
        train_df=pd.DataFrame(X_final)
        scaler = MinMaxScaler(feature_range=(0,1))
        scaled_train = scaler.fit_transform(train_df)
        scaled_train_df = pd.DataFrame(scaled_train, columns=train_df.columns.values)
        
        val=[]
        val_total=[]
        X = scaled_train_df[scaled_train_df.columns[:25]].values
        count=0
        for i in range(X.shape[0]):
            count+=1
            val1=model.predict(X[i].reshape(1,X[i].shape[0]))
            val.append(val1)
            if count==2:
                val_total.append(val)
                val=[]
                count=0

        pop_size=38
        no_offspring=pop_size-no_parent
        fitness=fitness_function(pop,val_total)
        parent=roulette_selection(pop,no_parent,fitness)
        offspring=crossover(parent,no_offspring,0.7)
        mutate=mutation(offspring,mutation_rate)
        pop=np.concatenate((pop,mutate),axis=0)
        
    return pop,fitness

if __name__ == "__main__":

    model=keras.models.load_model('ML_Model.h5')
    all_geometry,all_results = load_dataset()
    pop,fitness=optimization(all_geometry,10,20,0.15,model)
    index=fitness.index(max(fitness))
    print(pop[index])




