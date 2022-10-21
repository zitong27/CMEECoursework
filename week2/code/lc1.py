birds = [ ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
]

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 
Latinlist=[i[0] for i in birds]
print(Latinlist)


Commonlist=[i[1] for i in birds]
print(Commonlist)


Bodylist=[i[2] for i in birds]
print(Bodylist)


# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
Latinlis=[]
for i in birds:
    Latinlis.append(i[0])

print(Latinlis)

Commonlis=[]
for i in birds:
    Commonlis.append(i[1])

print(Commonlis)

Bodylis=[]
for i in birds:
    Bodylis.append(i[2])

print(Bodylis)


