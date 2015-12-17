# This script generates directories for my Piskel-Art Github repository
# New feature! Now I can create these directories from a single csv file
# This code was created for @piskelapp

import os,csv
# ------------------------------------------------------------

# THE TACKY CODE
# ------------------------------------------------------------
root = os.getcwd()

def generate(type):
	try:
		os.makedirs(type)
	except:
		None 
	os.chdir(type)	
	folders = ['32','256','1024','Animations','Palettes']
	for folder in folders:
		try:
			os.makedirs(folder)
		except:
			print 'Directory %s already exists in %s.'%(folder,type)
	with open(type+'.piskel','w') as outfile:
		outfile.write('')
	print('Directories in {} are:\n'.format(type)+str(os.listdir(os.getcwd())))
	print('\n')
# ------------------------------------------------------------


def create_dirs(prefix,L):
    "creates directories with a prefix from a list L "
    for item in L:
	   os.chdir(root)
	   generate(prefix+item)

# I could save these in a csv file and then create folders from it.
# ------------------------------------------------------------


# Done!
def create_csv_dirs(obj_type):
    with open('characters.csv','r') as infile:
        csv_file = csv.reader(infile)
        for item in csv_file:
            create_dirs(obj_type,item)


# IMPLEMENTATION
# ------------------------------------------------------------
test_objects = ['chrs_base_front','chrs_base_side','chrs_base_back']


create_dirs('chr_',test_objects)
create_csv_dirs('chr_')
