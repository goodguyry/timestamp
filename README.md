TimeStamp
=========

An AppleScript applet to timestamp files from the Finder toolbar. It's set up to work two ways:

1. **As a droplet**  
Drop a file or folder on the TimeStamp icon and the file or folder's name will be appended with the timestamp.
2. **As an applet or run as an AppleScript**  
Select a file or folder and click the TimeStamp icon to duplicate the selected file and have its name appended with a timestamp, preserving the original file or folder's name.

## How do you work this thing?
### Run it as you would any other AppleScript
The easiest way to do this is to drop the script file into your _~/Library/Scripts_ folder and run it from the Script menu in the menu bar. To enable the Script menu, open AppleScript Editor (/Applications/Utilities/AppleScript Editor.app) and  enable the option for "Show Script menu in menu bar" in the AppleScript Editor's preferences window.

\* Please note that running this from the Script menu will only run the default ````run```` handler, which duplicates the file and timestamps the duplicate file, so you may want to alter the code if that's not how you want it to run.

### Save it as an application
Open the script in AppleScript Editor and select "Application" from the _Save As_ menu. From there, there are a couple extra steps.

1. **Add the icon file to the Resources folder**  
Right-click your application file and select "Show Package Contents". Open the _Contents/Resources_ folder and drag the included .icns file (or your own, whatever) into this folder. Go ahead and copy the filename to the clipboard.
3. **Alter the icon file key in the plist to enable the icon file.**  
In the _Contents_ folder is your Infor.plist file. Open this file in your editor of choice and find the ````CFBundleIconFile```` key. Change the associated ````<string>```` entry (directly after ````<key>CFBundleIconFile</key>````) to reflect the name of your icon file (without the file extension). If you've used the included icon file, your plist file should read:  
````  
<key>CFBundleIconFile</key>
<string>timestamp</string>  
````  
Keep that plist file open, dawg...
2. **Add a key to the plist file so the dock icon will remain hidden.**   
In order to keep TimeStamp from showing a dock icon (which, IMHO is dumb and pointless for this type of application), you need to _add_ the following to the plist file:  
````
<key>LSUIElement</key>
<string>1</string>
````

## Optional Setup
**Changing the applet and droplet bevahiors**
The following handler call passes a boolean value to a ````fileDup```` variable.

````my addTimeStamp(boolean)````

This handler appears twice - once in the ````run```` handler and once in the ````open names```` handler.

- When ````true````, the selected/dropped file will be duplicated and the duplicate file will be timestamped, which preserves the original file or folder name.
- When ````false````, the selected/dropped file will be timestamped without duplication.

**Changing the timestamp formatting**

In the ````formatDate(x)```` handler, ````x```` is the date passed. Inside the function, the date/time formatting can be altered to suit your needs.
