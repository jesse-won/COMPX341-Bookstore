import sys
import os
import re

# Declare comment convention
comments = ["// Name                    ID\n", "// Jesse Reyneke-Barnard   1351388\n"]

# Compile file regular expression pattern
pattern = re.compile("^.*\.ts$")
# Search src directory for all files
for root, dirs, files in os.walk("./src"):
    for name in files:
        if (pattern.match(name)):
            print("test-comments -> info -> checking file: \"" + os.path.join(root, name) + "\"")
            # If the correct file was found, check it for correct comment header convention
            f = open(os.path.join(root, name)) # Open file
            l = f.readline() # Read initial line
            for c in comments:
                if (c != l):
                    print("test-comments -> fail -> file: \"" + os.path.join(root, name) + "\"")
                    print("                         line: \"" + l.encode('unicode_escape').decode('ASCII') + "\"")
                    print("                     expected: \"" + c.encode('unicode_escape').decode('ASCII') + "\"")
                    sys.exit(1)
                else:
                    l = f.readline()
            print("test-comments -> pass -> file: \"" + os.path.join(root, name) + "\" matches comment header convention")
print("test-comments -> pass -> all files had the correct comment format")
sys.exit(0)