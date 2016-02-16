import csv, sys, xml.etree.ElementTree as ET
from xml.etree.ElementTree import Element, SubElement, Comment, tostring
import pprint



tree = ET.parse('mods_broadsides_20150723.xml')
root = tree.getroot()

lunaTree=ET.parse('luna_broadsides-20150625.xml')
lunaRoot=lunaTree.getroot()






records=root.findall('{http://www.loc.gov/mods/v3}mods')
lunaRecords=lunaRoot.findall('{http://www.lunaimaging.com/xsd}record[@type="MODS"]')


fileNames={}


for record in records:
	for identifier in record.findall('{http://www.loc.gov/mods/v3}identifier[@type="local"]'):

		for callno in record.findall('{http://www.loc.gov/mods/v3}location/{http://www.loc.gov/mods/v3}shelfLocator'):
		
			fileNames.update({identifier.text:callno.text})


for record in lunaRecords:
	location=SubElement(record,'{http://www.lunaimaging.com/xsd}fieldGroup')
	location.set('type','Location')
	shelfNo=SubElement(location,'{http://www.lunaimaging.com/xsd}field')
	shelfNo.set('type','Call Number')
	repository=SubElement(location,'{http://www.lunaimaging.com/xsd}field')
	repository.set('type','Repository')
	repository.text='Kenneth Spencer Research Library, University of Kansas'
	accessCond=SubElement(record,'{http://www.lunaimaging.com/xsd}fieldGroup')
	accessCond.set('type','Access Condition')
	rights=SubElement(accessCond,'{http://www.lunaimaging.com/xsd}field')
	rights.set('type','Rights')
	rights.text='This work is in the public domain and is available for users to copy, use, and redistribute in part or in whole. No known restrictions apply to the work.'
	
	for lunaID in record.findall('{http://www.lunaimaging.com/xsd}fieldGroup[@type="ID"]/{http://www.lunaimaging.com/xsd}field[@type="Identifier"]'):
		
		for name in fileNames:
			if lunaID.text==name:
				#print lunaID.text + " = "+name
				shelfNo.text=fileNames.get(name)
lunaRecords.append(location)
lunaRecords.append(shelfNo)
lunaRecords.append(repository)
lunaRecords.append(accessCond)
				#print tostring(record)
lunaTree.write('newOut.xml', encoding='UTF-8',xml_declaration=True)
				

			
		
	
		
	
	