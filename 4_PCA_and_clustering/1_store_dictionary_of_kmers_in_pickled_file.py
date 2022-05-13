import sys
from os import listdir
from os.path import isfile, join
import pickle

#read files into a dictionary
path_to_files = sys.argv[1] #path to sorted k-mer profiles
pickle_file_name = sys.argv[2] #file with extension .p to store pickled dictionary of k-mers

if(path_to_files[-1] != '/'):
    path_to_files = path_to_files + '/'

onlyfiles = [f for f in listdir(path_to_files) if isfile(join(path_to_files, f))]


onlyfiles.sort()



dict_with_freqs = {}

for i in range(len(onlyfiles)):
    file_to_process = path_to_files + onlyfiles[i]
    with open(file_to_process) as f_in:
        for line in f_in:
            key_val = line.strip().split(' ')

            key = key_val[0]
            val = key_val[1]

            dict_with_freqs.setdefault(key, []).append(val)


#pickle the dictionary
pickle.dump(dict_with_freqs,open(pickle_file_name,"wb"))
