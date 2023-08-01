import json

adjacency_list = {
    'A': [('B', 1), ('C', 3), ('D', 7), ('E', 1)],
    'B': [('D', 5)],
    'C': [('D', 12)]
}

json_object = json.dumps(adjacency_list, indent=4)

y = json.loads(json_object)

print(y)