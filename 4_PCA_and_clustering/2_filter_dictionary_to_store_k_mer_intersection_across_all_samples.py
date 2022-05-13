import sys
from os import listdir
from os.path import isfile, join
import pickle


pickled_dictionary = sys.argv[1] #path to pickled dictionary .p file

num_samples = int(sys.argv[2])

kmer_frequencies_dictionary = pickle.load( open( pickled_dictionary, "rb" ) )

#remove keys for which len of value list is less than number of samples (only store k-mers present across all samples)
dictionary_intersection_of_all_samples = {k: v for k, v in kmer_frequencies_dictionary.items() if len(v) == num_samples}

#pickle the filtered dictionary
pickle.dump(dictionary_intersection_of_all_samples, open("21_mer_intersection_across.p","wb"))
