import struct
import zlib
import os

def create_data_dat():
    xml = """<?xml version="1.0" encoding="UTF-8"?>
<i>
    <i label="Character" id="character/" type="0">
        <i name="Face" data="character/Face/">
            <i id="00000123" n="Example Face"/>  <!-- Changed: removed url attribute, using id -->
        </i>
    </i>
    <i label="Miscellaneous" id="etc/" type="7">
        <i name="Basic" data="etc/Basic/">
            <i id="00000456" n="Example Misc"/>  <!-- Changed: removed url attribute, using id -->
        </i>
    </i>
</i>"""
    
    xml_bytes = xml.encode('us-ascii')
    length = struct.pack('>I', len(xml_bytes))
    data = length + xml_bytes
    compressed_data = zlib.compress(data)
    
    os.makedirs('dat', exist_ok=True)
    with open('dat/data.dat', 'wb') as f:
        f.write(compressed_data)

def create_th_file(filename, entries):
    # Create a 16x16 thumbnail image (16 colors, 4 bits per pixel)
    thumbnail_width = 16
    thumbnail_height = 16
    thumbnail_data = bytearray([0x11] * (thumbnail_width * thumbnail_height // 2))
    compressed_thumb = zlib.compress(thumbnail_data)
    
    # Build table entries - note the format change here
    table_parts = []
    for entry in entries:
        # Format: ID-imagename;width;height;position;length;
        table_parts.extend([
            f"{entry}-default",  # Just the ID, path comes from data.dat
            "10",               # width (16 in hex)
            "10",               # height (16 in hex)
            "0",                # position in thumbnail data
            f"{len(thumbnail_data):x}"  # length in hex
        ])
    
    table_str = ";".join(table_parts) + ";"
    table_bytes = table_str.encode('us-ascii')
    compressed_table = zlib.compress(table_bytes)
    
    os.makedirs('thumbs', exist_ok=True)
    with open(f'thumbs/{filename}.th', 'wb') as f:
        f.write(compressed_thumb)
        f.write(compressed_table)
        f.write(struct.pack('>I', len(compressed_table)))

def create_pak_file(path, filename, is_character=False):
    # Different XML structure for character vs non-character items
    if is_character:
        xml = """<?xml version="1.0" encoding="UTF-8"?>
<i>
    <i name="face_mixer">
        <i/>
    </i>
    <i name="animation">
        <i path="stand1.0" delay="100" zigzag="0" image="default"/>
    </i>
    <i name="images">
        <i name="default" client="0" width="16" height="16" length="1024" position="0"/>
    </i>
</i>"""
    else:
        xml = """<?xml version="1.0" encoding="UTF-8"?>
<i>
    <i name="animation">
        <i path="0" delay="100" zigzag="0" image="default"/>
    </i>
    <i name="images">
        <i name="default" client="0" width="16" height="16" length="1024" position="0"/>
    </i>
</i>"""
    
    # Create a 16x16 RGBA image
    image_data = bytearray([255, 255, 255, 255] * (16 * 16))
    
    # First compress the XML
    xml_bytes = xml.encode('us-ascii')
    xml_compressed = zlib.compress(xml_bytes)
    
    # Write the length of the COMPRESSED XML data
    xml_len_bytes = struct.pack('>I', len(xml_compressed))
    
    # Compress the image data separately
    image_compressed = zlib.compress(image_data)
    
    # Combine everything:
    # 1. Length of compressed XML (4 bytes)
    # 2. Compressed XML
    # 3. Compressed image data
    full_data = xml_len_bytes + xml_compressed + image_compressed
    
    os.makedirs(f'pak/{path}', exist_ok=True)
    with open(f'pak/{path}/{filename}.pak', 'wb') as f:
        f.write(full_data)

def main():
    # Create data.dat with both sections
    create_data_dat()
    
    # Create PAK files for both sections with appropriate flags
    create_pak_file('character/Face', '00000123', is_character=True)
    create_pak_file('etc/Basic', '00000456', is_character=False)  # Misc/Etc item
    
    # Create thumbnail files
    create_th_file('character', ['00000123'])
    create_th_file('etc', ['00000456'])

if __name__ == '__main__':
    main()