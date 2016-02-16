import sys
import xml.etree.ElementTree as ET

xmlFile1=sys.argv[1]
xmlFile2=sys.argv[2]

ET.register_namespace('mods',"http://www.loc.gov/mods/v3")

tree1=ET.parse(xmlFile1)
tree2=ET.parse(xmlFile2)

root1=tree1.getroot()
root2=tree2.getroot()

records1=root1.findall('row')
records2Prefix='{http://www.loc.gov/mods/v3}'
records2=root2.findall(records2Prefix+'mods')

for row in records1:
    id1=row.findall('BIB_ID1')
    if len(id1)>1:
        print "Very broken"
        exit()
    id1=id1[0].text
    fileName=row.findall('Filename1')
    
    if len(fileName)>1:
        print "Very broken"
        exit()
    fileName=fileName[0].text
    dod=row.findall('Date_Digitized1')
    if len(dod)>1:
        print "Very broken"
        exit()
    dod=dod[0].text
    for record in records2:
        jamID=record.getchildren().index(record.findall(records2Prefix+'identifier')[0])
        OriginInfo=record.findall(records2Prefix+'originInfo')
        recordInfo=record.findall(records2Prefix+"recordInfo")
        if len(recordInfo)>1:
            print "Very broken"
            exit()
        if len(OriginInfo)>1:
            print "Very broken"
            exit()
        recordInfo=recordInfo[0]
        OriginInfo=OriginInfo[0]
        id2=recordInfo.findall(records2Prefix+"recordIdentifier")[0].text
        if id1==id2:
            #the ids match, insert a filename element here
            #print "hit "+id1+" is "+id2
            #print dod
            newFilename=ET.Element('mods:identifer')
            newFilename.text=str(fileName+'.tif')
            newFilename.set('type','local')
            record.insert(jamID,newFilename)

            dateCaptured=ET.Element('mods:dateCaptured')
            dateCaptured.text=str(dod)
            dateCaptured.set('encoding','w3cdtf')
            OriginInfo.append(dateCaptured)
    
tree2.write('newOut.xml', encoding='UTF-8')