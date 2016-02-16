#!/usr/bin/python2

import sys

import xml.etree.ElementTree as ET

xmlFile = sys.argv[1]

tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')





records=root.findall('{http://www.loc.gov/mods/v3}mods')

for record in records:
    identifier=record.findall('{http://www.loc.gov/mods/v3}identifier[@type="oclc"]')
    if len(identifier)==2:
        record.remove(identifier[1])
    


        
tree.write('newOut.xml')
