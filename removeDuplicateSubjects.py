#!/usr/bin/python2

import sys

import xml.etree.ElementTree as ET

xmlFile = sys.argv[1]

tree = ET.parse(xmlFile)
root = tree.getroot()

xmlData = open(xmlFile,'r')


records=root.findall('{http://www.lunaimaging.com/xsd}record')


for record in records:
    subjectList=[]
    for field in record:
        if field.attrib['type'] == "Subject":
            for subject in field:
                if subject.text in subjectList:
                    field.remove(subject)
                subjectList.append(subject.text)
tree.write('newOut.xml')