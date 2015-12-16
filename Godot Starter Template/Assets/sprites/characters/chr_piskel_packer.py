# This script generates directories for my Piskel-Art Github repository
# link... to repo

import os
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


# IMPLEMENTATION
# ------------------------------------------------------------
objects = ['chrs_base_front','chrs_base_side','chrs_base_back']

def create(x):
    for obj in x:
	   os.chdir(root)
	   generate('chr_'+obj)

# I could save these in a csv file and then create folders from it.
# ------------------------------------------------------------

with open('characters.csv','r') as infile:
    text = infile.readline()
    print(text)