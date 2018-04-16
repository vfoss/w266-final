# This script takes about 8 minutes to run

import nltk
import time
import pandas as pd
import collections
import pickle


## Extracting Articles with Gender Labels

print("Building two counters for words found in Wiki biographies of women and of men...")
start = time.time()

gender_label_table = pd.read_csv("data/wiki.genders.txt", sep='\t')

is_male = {}
for _, row in gender_label_table.iterrows():
    is_male[str(row["wiki id"])] = (row["gender"] == 'MALE')
del gender_label_table

male_counter = collections.Counter()
female_counter = collections.Counter()

try:
    with open("data/gendered-labeled-articles.stripped", 'r') as f:
        for line in f:
            words = line.split()
            if is_male[words[0]]:
                male_counter.update(words[1:])
            else:
                female_counter.update(words[1:])
finally:    
    print("Done.")



## Save (pickle) data structures for faster loading

print("Saving results...")

def save_object(obj, filename):
    with open(filename, 'wb') as outfile:  
        pickle.dump(obj, outfile, pickle.HIGHEST_PROTOCOL)

save_object(female_counter, 'data/female_counter.pkl')
save_object(male_counter, 'data/male_counter.pkl')
save_object(is_male, 'data/is_male.pkl')

print("Done.")
print("Total time:", time.time() - start, "seconds")

