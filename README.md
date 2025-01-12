# BannedStory 4 Revived
This project is an effort to revive the MapleStory design simulator program, BannedStory 4.

BannedStory 4 was a program way ahead of its time and loved by thousands of users. Unfortunately, the website hosting the application was shutdown and the developer of the project has been uncontactable since. An offline distributable of the program was never made, and the application used the Adobe Flash platform, which reached end of life in 2020 with modern browsers no longer supporting Flash Player at all.

Fortunately, thanks to the effort from the team behind [ruffle](https://github.com/ruffle-rs/ruffle/), we now have an easy and distributable way to run Flash programs again.

The revived program will be hosted at http://bannedstory4.com/

## What work is left to completely bring BannedStory 4 back to life?

So far I have been able to get the SWF running and circumvent the built in authentication so that the program starts and attempts to load assets.

The remaining work required is re-creating its asset data. The program was exclusively hosted on maplesimulator.com, and all of its assets were stored on it's webserver, so unfortunately we don't have access to them.

I have been able to successfully decompile the code using [jpexs-decompiler](https://github.com/jindrapetrik/jpexs-decompiler), but discovered that BannedStory 4 uses multple custom data format's that are interdependent on each other, so now we need to 

1. correctly reverse engineer the formats
2. convert existing MapleStory data from .wz files into BannedStory 4 formats.

So for I have been able to create test data that is loadable by the program, but more data and testing is needed before we can be sure the formats are correct.

### What do we know so far regarding its data format?
BannedStory 4 requires assets in the form of 3 files formats:
- .dat 
- .pak
- .th

There is one .dat file, named `data.dat` that serves as the program's file index, with the list of categories and items.

Each item in `data.dat` requires a corresponding `.pak` file containing the actual asset, an entry in the appropriate `.th` file for its thumbnail. The thumbnail file is important because it is what the UI uses to actually load the .pak `files`.

## File Formats
WIP - not completely correct, this is just the current understanding from reverse engineering based on the decompiled code and testing with sample data created using the `create_test_data.py` script.

### .dat format
```
Structure:
[4 bytes] - Length of uncompressed XML (uint32, big endian)
[N bytes] - zlib compressed XML data
XML Structure:

<i>
    <i label="Category" id="category/" type="type_number">
        <i name="Subcategory" data="category/subcategory/">
            <i id="itemid" n="Display Name"/>
        </i>
    </i>
</i>
```
### .pak format
```
Structure:
[4 bytes] - Length of compressed XML (uint32, big endian)
[N bytes] - zlib compressed XML data
[M bytes] - zlib compressed image data (RGBA format)
XML Structure for Character items:
<i>
    <i name="face_mixer">
        <i/>
    </i>
    <i name="animation">
        <i path="stand1.0" delay="100" zigzag="0" image="default"/>
    </i>
    <i name="images">
        <i name="default" client="0" width="W" height="H" length="L" position="P"/>
    </i>
</i>

XML Structure for Misc/Etc items:
<i>
    <i name="animation">
        <i path="0" delay="100" zigzag="0" image="default"/>
    </i>
    <i name="images">
        <i name="default" client="0" width="W" height="H" length="L" position="P"/>
    </i>
</i>
```

### .th format
```
Structure:
[N bytes] - zlib compressed thumbnail image data (4-bit per pixel)
[M bytes] - zlib compressed table data
[4 bytes] - Length of compressed table (uint32, big endian)

Table Format:
- ASCII text with entries separated by semicolons
- Each entry format: ID-imagename;width;height;position;length;
Example:
"00000123-default;10;10;0;100;"

Where:
- ID matches the item ID from data.dat
- imagename typically "default"
- width/height in hex
- position is offset in thumbnail data
- length is size of thumbnail data in hex
```

## Developer Setup
To run the SWF locally and test assets, included in this repo in `flash-debugger` folder is the portable .exe for Flash Player 32. 

Flash Player won't let an SWF read local files due to security restrictions. Normally we could change this setting in the Flash Player Global Security Settings, but since that is no longer available, you'll need to run the program, close it, then in `%appdata%\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys`, replace the `settings.sol` file with the one included in this repo. This will enable developer settings for SWF files.