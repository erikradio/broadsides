from lxml import etree
import sys

tree = etree.parse(sys.argv[1])
root = tree.getroot()

for elem in root.iter('*'):

    if elem.text is not None:
        elem.text = elem.text.strip()

    #if elem.tail is not None:
        #elem.tail = elem.tail.strip()

print(etree.tostring(root, encoding="utf-8", xml_declaration=True))

tree.write('newOut.xml')