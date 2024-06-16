import json
import re

lines:list[str] = []
with open("config", "r") as file:
    lines = file.readlines()
    
mappings = {}

commentRe = r'^[^#]*$'

currType = "_"
for i in range(len(lines)):
    line = lines[i]
    if line.startswith("#-------------------------#"):
        currType = None
    if currType == None and line.startswith("# "):
        currType = line[2:].strip()
    if line.startswith("bindsym"):
        description = "No description"
        if i!=0 and not re.match(commentRe, lines[i-1]):
            description = lines[i-1][lines[i-1].rfind("#"):].strip()
        t = line.split()
        mapping = t[1]
        com = ' '.join(t[2:])
        if not currType in mappings.keys():
            mappings[currType] = []
        mappings[currType].append([mapping, com, description])
        # print(currType)
        # print(mapping)
        # print(com)

# print(mappings)
# print(json.dumps(mappings))
for key, items in mappings.items():
    print(key)
    for mapping, com, desc in items:
        print(f"    {mapping}")
        print(f"        {com}")
        print(f"        {desc}")
