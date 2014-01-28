EECE5698 Found of Visualization
Hw 4
Tim Liming

---------------------
Python Scripts README
---------------------

stations.py
-----------
Generates a list of station names, with one station name per row.
Writes the list to file: "stations.csv"

Uses a HTMLParser to extract station data from the data.html input file.


connections.py
--------------
Generates a list of MBTA connection data.
The row format is as follows: "From", "To", "Color", "Minutes".
Writes the list to file: "connections.csv"

Uses a HTMLParser to extract connection data from the data.html input file.


Make sure the data.html file is in the same directory as the python scripts.