# EECE5698 Foundations of Visualization
# Tim Liming
# Homework 4

# connections.py
""" Generates a list of MBTA connection data.
    The row format is as follows: "From", "To", "Color", "Minutes".
    Writes the list to file: "connections.csv".
"""

# files used in this script
input_file = open("data.html", "r")
output_file = open("connections.csv", "w")

# initialize the arrays for connection data
connections = []
To = []
From = []
Line = []
Minutes = []

# Create a HTML Parser so we can grab data
from html.parser import HTMLParser
class MyHTMLParser(HTMLParser):
    def handle_data(self, data):
        # build the station array
        connections.append(str(data))

parser = MyHTMLParser()


# loop through html code and extract data lines
for line in range(537, 1378, 7):
    
    # we must open the file each iteration
    input_file = open("data.html", "r")
    
    # grab the four data lines we want from the file
    data = input_file.readlines()[line:line+4]

    # feed each line to the parser
    for i in range(0, 4):
        temp = parser.feed(data[i])


# loop through and store data in correct arrays
for i in range(1, len(connections), 12):
    To.append(connections[i])
    From.append(connections[i+3])
    Line.append(connections[i+6])
    Minutes.append(connections[i+9])


# loop trough arrays and add to CSV line
for i in range(0, len(To)):
    # write data to output file
    output_file.write(str(To[i]) + ',' + 
                      str(From[i]) + ',' + 
                      str(Line[i]) + ',' + 
                      str(Minutes[i]) + '\n')
 

# close files
input_file.close()
output_file.close()

