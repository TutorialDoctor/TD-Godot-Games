import os

rootDir = '.'
                    
# Traverses from the current directory finding images of type x and creates a markdown file with image links to those images
def markdown_images(x):
    for dirName,subdirList, fileList in os.walk(rootDir,topdown=False):
        #print dirName
        for fname in fileList:
            path,ext = os.path.splitext(fname)
            if ext == x:
                print '[{}] {}'.format(dirName,fname)
                with open(x.split('.')[1]+'.md','a') as outfile:
                    outfile.write("\n![]({}){}\n".format(dirName+'/'+fname,fname))


                    
# Implementation
images = ['.png','.jpg','.jpeg','.bmp']
for i in images:
    markdown_images(i)


    
# EXTRA STUFF
def simple_walk():
    #root prints out directories only from what you specified
    #dirs prints out sub-directories from root
    #files prints out all files from root and directories
    for root, dirs, files in os.walk("."):
        print root
        print dirs
        print files


# Traverses from the current directory finding files of type x and creates a text file listing the files
def find_files(x):
    for dirName,subdirList, fileList in os.walk(rootDir,topdown=False):
        #print dirName
        for fname in fileList:
            path,ext = os.path.splitext(fname)
            if ext == x:
                print '[{}] {}'.format(dirName,fname)
                with open(x.split('.')[1]+'.txt','a') as outfile:
                    outfile.write(fname+'\n')

find_files('.txt')