# EECE5698 Foundations of Visualization
# Tim Liming
# Homework 4

# stations.py
""" Generates a list of station names, with one station name per row.
    Writes the list to file: "stations.csv".
"""

# files used in this script
input_file = open("data.html", "r")
output_file = open("stations.csv", "w")

# initialize an array for the stations
station = []

# Create a HTML Parser so we can grab data
from html.parser import HTMLParser
class MyHTMLParser(HTMLParser):
    def handle_data(self, data):
        # build the station array
        station.append(str(data))

parser = MyHTMLParser()


# loop through html code and extract data lines
for line in range(19, 520, 4):
    
    # we must open the file each iteration
    input_file = open("data.html", "r")
    
    # grab the line from the file
    data = input_file.readlines()[line]

    # feed the line to the parser which will extract our data
    temp = parser.feed(data)

    
# loop through station array and extract station names
for i in range(1, 378, 3):
    
    # write station name into output file
    output_file.write(str(station[i]) + '\n')
    

# close files
input_file.close()
output_file.close()
