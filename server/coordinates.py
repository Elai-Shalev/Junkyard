import json
import random

def generate_coordinates(lat, lon, num_points, box_size=0.01):
    coordinates = []
    for _ in range(num_points):
        new_lat = lat + random.uniform(-box_size, box_size)
        new_lon = lon + random.uniform(-box_size, box_size)
        coordinates.append((new_lat, new_lon))
    return coordinates

# Generate 50 coordinates around 32.109333, 34.855499
coords = generate_coordinates(32.109333, 34.855499, 50)

# Load the JSON data from the file
with open('data/pieces.json', 'r') as f:
    data = json.load(f)

# Check that the number of coordinates matches the number of items in the data
if len(coords) != len(data):
    print("Error: Number of coordinates does not match number of items in data!")
else:
    # Update the 'location' field for each item with a generated coordinate
    for i in range(len(data)):
        data[i]['location'] = {
            "type": "Point",
            "coordinates": list(coords[i])
        }

    # Save the updated data back to the file
    with open('data/pieces.json', 'w') as f:
        json.dump(data, f, indent=4)

print("Updated pieces.json with new coordinates.")
