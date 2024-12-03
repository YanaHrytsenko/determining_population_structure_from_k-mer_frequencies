
#faststructure instructions for personal mac

#on andromeda
#merge vcf
#convert to plink format
#download output files

#locally
#get py27 and run in env
#CONDA_SUBDIR=osx-64 conda create -n py27 python=2.7  # include other packages here

# ensure that future package installs in this env stick to 'osx-64'
#conda activate py27
#conda config --env --set subdir osx-64

#conda install cython=0.24.1

#install fast structure - see https://github.com/rajanil/fastStructure
#cd /Users/rsschwartz/Desktop/URI/papers/pop_structure_kmer_freq/
#mkdir structure
#cd structure
#git clone https://github.com/rajanil/fastStructure
#cd fastStructure
#git fetch
#git merge origin/master
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#export CFLAGS="-I/usr/local/include"
#export LDFLAGS="-L/usr/local/lib"
#python setup.py build_ext --inplace
#cd vars
#python setup.py build_ext --inplace
#cd ..

#test - see https://github.com/rajanil/fastStructure

FILENAME=basic

STR_FOLDER=/Users/rsschwartz/Desktop/URI/papers/pop_structure_kmer_freq/structure/fastStructure

DATA_FOLDER=$FILENAME

mkdir $DATA_FOLDER 

for K in $(seq 2 6); do
    python $STR_FOLDER/structure.py -K $K --input=$FILENAME  --output=${DATA_FOLDER}/${FILENAME}.structuretest --full --seed=100
done

python ${STR_FOLDER}/chooseK.py --input=${DATA_FOLDER}/${FILENAME}.structuretest

python ./fastStructure/distruct.py -K 5 --input=basic/basic.structuretest --output=basic/basic.structuretest_distruct.svg --popfile=basic_pops.txt
