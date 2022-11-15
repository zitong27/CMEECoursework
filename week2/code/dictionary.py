#!/usr/bin/env python3

""" Populating taxa_dic dictionary derived from taxa, maping order names to sets of taxa."""


taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. OR, 'Chiroptera': {'Myotis
#  lucifugus'} ... etc

#### Your solution here #### 

taxa_dic ={}
for i in taxa:
    taxa_dic.setdefault(i[1],set()).add(i[0])
print(taxa_dic)



# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
#### Your solution here #### 

taxa_dic={} 
taxa_dic={i[1]:set(k[0] for k in taxa if k[1]==i[1]) for i in taxa}
print(taxa_dic)

taxa_di={} 
for i in taxa:
    value=[]
    key = i[1]
    for k in taxa:
        if k[1]==i[1]:
            value.append(k[0])    

    taxa_di[i[1]]=set(value)

print(taxa_di)

    



   
