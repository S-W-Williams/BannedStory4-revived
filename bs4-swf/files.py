import struct
import zlib

def create_data_dat():
    # The exact XML structure needed for character faces
    xml = """<?xml version="1.0" encoding="UTF-8"?>
    <i label="Main" id="main">
        <category type="7">
            <subcategory data="etc/Basic">
                <item id="00000123" type="4" n="Test Item" visible="1" url="etc/Basic/00000123.pak"/>
            </subcategory>
        </category>
    </i>"""

    # Convert XML to ASCII bytes
    xml_bytes = xml.encode('us-ascii')
    
    # Pack the length as big-endian unsigned int (4 bytes)
    length = struct.pack('>I', len(xml_bytes))
    
    # Combine length and XML data
    data = length + xml_bytes
    
    # Compress the entire data block
    compressed_data = zlib.compress(data)
    
    # Write to file
    with open('data.dat', 'wb') as f:
        f.write(compressed_data)

def main():
    create_data_dat()
    print("Created data.dat with character face XML structure")

if __name__ == '__main__':
    main()