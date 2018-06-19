---
title: ""
---
# COBIAN BACKUP TOOL GUIDE

## Cobian Backup  
Backing up your computer files

**Lesson to read: [Backing Up](umbrella://lesson/backing-up)**  
**Download Location:** [http://www.cobiansoft.com/cobianbackup.htm](http://www.cobiansoft.com/cobianbackup.htm)  
**Computer requirements:**   
- XP, 2003, Vista, 2008, Windows 7  
- Windows 95, 98 and ME are compatible with Cobian version 7.  
**Version used in this guide:** Cobian 10  
**License:** Freeware  
**Level:**  Intermediate  
**Time required:** 30 minutes

### 1. Things you should know about this tool before you start

Cobian Backup is used to archive, (or to make a backup copy) of your files and directories. Backups can be stored in other directories or drives on your computer, other computers on the office network, or on removable devices (CDs, DVDs and USB memory sticks). Cobian Backup lets you archive your directories and files on a regular basis. It works silently in the background on your system (that is, in the system tray), checking your schedule and executing the backup process when necessary. Cobian Backup can also compress and encrypt files as it generates the backup file.

- Using Cobian will give you:  
- The ability to back up all documents, files and folders  
- The ability to compress and decompress your backup files  
- The ability to encrypt and decrypt your archived files

**Installing Cobian - in brief**  
- Open www.cobiansoft.com/cobianbackup.htm  
- Click on the link "Download Cobian Backup" on the page.  
- Save the installer, then find it and doubleclick it  
- Read the 'Installation Note' below before you continue  
- After you have successfully installed Cobian you may delete the installation program from your computer.

### 2.0 How to Install Cobian Backup

**Installation Note:** Before you begin the installation process, verify that you have both the latest versions of the **Microsoft Windows Installer** and the **Microsoft.NET Framework**.

Installing Cobian Backup is a relatively easy and quick procedure. 

**Step 1.** Double click "cbsetup.exe"; the _Open File - Security Warning_ dialog box may appear. If it does, click "Run" to activate the light blue _Extracting the resource_ progress status bar, followed a few moments later by the following screen:
![image](tool_cobian1.png)

**Step 2.** Click "Next" to activate the _Please read and accept the license agreement screen_ check the _I accept_ option, and then click "Next" again to activate the following screen:
![image](tool_cobian2.png)

**Step 3.** Click "Next" to activate the following screen:
![image](tool_cobian3.png)

**Step 4.** Check the _Use Local System account_ option in the _Service options_ pane, so that your own resembles Figure 3 above. This option ensures that Cobian Backup will be running silently in the background all the time, so that your backups will occur as scheduled.

**Step 5.** Click "Next" to activate the following message prompt:
![image](tool_cobian4.png)

**Step 6.** Click "Yes" to activate the next installation screen, and then click "Next" to continue with the installation process.

**Step 7.** Click "Done" to complete the installation process. After the installation process has been completed, the Cobian Backup icon will appear in the **Windows System Tray**.

### 2.1 How to Backup Your Directories and Files

In this section you will learn how to perform a simple backup or archive of a specified files and/or folders. Cobian Backup uses a _backup task_ which can be configured to include a specified group of files and/or folders. A backup task can be set to run on a specified day and time.

To create a new backup task, perform the following step:

**Step 1.** Click "Schedule" to create a new backup task, and activate the _New task_ window as follows:
![image](tool_cobian5.png)

The left sidebar lists a number of tabs and their associated screens - used to set different backup options and parameters - are displayed in the pane at right. All the options in the _General_ tab are described below:

### 2.1.1 Option Descriptions

_Task Name:_ This _Task Name_ text field lets you enter a name for the backup task. Use a name that identifies the nature of the backup. For example, if the backup is going to contain video files, you could name it _Video Backup_.

_Disabled:_ This option _must_ be left unchecked.  
Warning: Enabling the _Disabled_ option will override the rest of the options, and prevent the backup task from running.

_Include Subdirectories:_ This option lets you include all the subdirectories/folders within a selected directory/folder for the backup task. This is an efficient method for backing up a large number of folders and/or files. As an example, if you select the _My Documents_ folder and check this option, then all files and folders in _My Documents_ will be included in the backup task.

_Create separated backups using timestamps:_ This option lets you specify that the date and time of the backup task will be automatically included in the folder name containing your backup file. This is a good idea because it means that you will easily be able to identify when the backup was performed.  
_Use file attribute logic:_ This option is only relevant when you choose to perform an incremental or differential backup (see below). File attributes contain information about the file.

**Note:** The following option is only available for Windows OS versions more recent than _and_ including Windows XP.

_Use Volume Shadow Copy:_ This option lets you backup files which are locked.  
Cobian Backup verifies this information to determine whether there has been a change in the source file from the last time a backup was performed. If you then run an _Differential_ or _Incremental_ backup, the file will be updated.

**Note:** You will only be able to run a full or 'dummy backup' if you _disable this option_ (the dummy backup option is explained below).

### 2.1.2 Backup type Descriptions

_Full:_ This option means that every single file in the source location will be copied to your backup directory. If you have enabled the _Create separated backups using timestamp_ option, you will have several copies of the same source (identified by the time and date of the backup in the folder title). Otherwise, Cobian Backup will overwrite the previous version (if any).

_Incremental:_ This option means the program will verify if the files selected for backup have been changed since the last backup was performed. If there has been no change, it will be skipped over during the backup process, saving backup time. The _Use file attribute logic_ option needs to be checked in order to perform this backup.

_Differential:_ The program will check if the source has been changed from the last **full** backup. If there is no need to copy that file, it will be skipped, saving backup time. If you have run a full backup before on the same set of files, then you can continue backing it up, using the Differential method.

_Dummy task:_ You can use this option to get your computer to run or shut down programs at certain times. This is a more advanced option which is not really relevant to our basic backup procedure.

**Step 2.** Click "OK" to confirm your search options and parameters for your backup task.

### 2.2 How to Create a Backup File

To begin creating a backup file, perform the following steps:

**Step 1.** Click "Files" in the left sidebar of the _New task_ window to display a _blank_ version of the following screen:
![image](tool_cobian6.png)

**Step 2.** Select the files you want to back up. (In _Figure 3_ above, the _My Documents_ folder is selected.)

**Step 3.** Click "Add" in the _Source_ pane to activate the _Directory_ menu.

**Step 4.** Select _Directory_ if you want to back up an entire directory, and _Files_ to back up individual files. To specify individual files or directories to be backed up, select _Manually_, and type in the file path or directory for your backup.

**Note:** You can add as many files or directories as you like. If you wish to back up files currently on your FTP server, choose the FTP site option (you will need to have the appropriate server login details).

When you have selected the files and/or folders, they will appear in the _Source_ area. As you can see in _Figure 3_ above, the _My Documents_ folder is displayed there, meaning this folder will now be included in the backup task.

The _Destination_ pane specifies where the backup will be stored.

**Step 5.** Click "Add" in the _Destination_ pane to activate the Directory menu.

**Step 6.** Select _Directory_ to open a browser window where you select the destination folder for your backup file.

**Note:** If you want to create several versions of the backup file, you may specify several folders here. If you selected the _Manually_ option, you must type in the full path to the folder where you want to keep the backup. To use a remote Internet server to store your archive, select the FTP site option (you will need to have the appropriate server login details).

The screen should now resemble the example above example with file(s) and/or folder(s) in the source area and folder(s) in the destination area. However, don't click _OK_ just yet! You still need to set a schedule for your backup.

### 2.3 How to Schedule Your Backup Task

For your automatic backup to work, you need to fill in the _Schedule_ section. This section lets you specify when you want the backup to be performed.  
To set the schedule options, perform the following steps:

**Step 1.** Select "Schedule" from the left sidebar, to activate the following pane:
![image](tool_cobian7.png)

The _Schedule type_ options are listed in the drop-down menu, and described below:

_Once:_ The backup will be done once only at the date and time specified in the _Date/Time_ area.

_Daily:_ The backup will be done every day at the time specified in the _Date/Time_ area.

_Weekly:_ The backup will be done on the days of the week selected. In the example above, the backup will be done on Fridays. You may select other days also. The backup will be done on all days selected at the time specified in the _Date/Time_ area.

_Monthly:_ The backup will be done on the days typed into the days of the month box at the time specified in the _Date/Time_ area.

_Yearly:_ The backup will be done on the days typed into the days of the month box, during the month specified, and at the time specified in the _Date/Time_ area.

_Timer:_ The backup will be done repeatedly at intervals specified in the Timer text box in the _Date/Time_ area.

_Manually:_ You will have to run the backup yourself from the main program window.

**Step 2.** Click "OK" to confirm the options and settings for the backup schedule as follows:
![image](tool_cobian8.png)

Once you have decided on a backup schedule, you have completed the final step. The backup will now run on the folders specified according to the schedule you have chosen.

### 3.0 How to Compress Your Backup File

**Step 1.** Create a backup task as documented in section 2.3, containing the backup files you want to archive.

**Step 2.** Select "Archive" from the left sidebar to activate the _New task_ screen as follows:
![image](tool_cobian9.png)

The **Compression** pane is used to specify the method for compressing your backup.

**Note:** Compression is used to reduce the amount of space for file storage. If you have a bunch of old files that you use only occasionally, but you still want to keep, it would make sense to store them in a format where they take up as little space as possible. Compression works by removing a lot of unnecessary coding out of your documents, while leaving important information intact. Compression does not damage your original data. The files are not viewable when compressed. The process must be reversed and your files 'decompressed' when you want to view the files again.

The three sub-options in the _Compression type_ drop-down list are:

_No Compression:_ This option does not perform any compression, as you would expect.

_Zip Compression:_ This option is the standard compression technique for **Windows** systems, and the most convenient. Archives once created can be opened with standard Windows tools (or you can download the [ZipGenius](http://www.zipgenius.it/) program to access them).

Selecting a compression type listed automatically enables the _Split options_ section, and its corresponding drop-down list.

The _Split options_ apply to storage on removable media, for example CDs, DVDs, floppy disks and USB memory sticks. The various split options will subdivide the archive into sizes that will fit onto your storage device of choice.

Example: Let's say that you are archiving a large number of files, and you want to burn them to a CD. However, your archive size turns out to be larger than 700MB (the size of a CD). The splitting function will split the archive into pieces smaller than or equal to 700MB, which you can then burn onto your CDs. If you are planning to back up onto your computer's hard disk, or the files that you want to back up are smaller than the device you plan to store them on, you can skip this section.

The following options are available to you when you click on the _Split options_ drop-down list. Your choice will depend on the type of removable storage device available to you.
![image](tool_cobian10.png)

- 3,5" - Floppy disk. This option is big enough to perform backup of a small number of documents  
- Zip - Zip Disk (check the capacity of the one you are using). You will need a special Zip Drive in your computer and the custom-made disks  
- CD-R - CD disk (check the capacity of the one you are using). You will need a CD Writer in your computer and a CD writing program (see [DeepBurner Free](http://www.deepburner.com/) version or other [disk burning tools](http://www.thefreecountry.com/utilities/dvdcdburning.shtml)).  
- DVD - DVD disk (check the capacity of the one you are using). You will need a DVD Writer in your computer and a DVD writing program (see [DeepBurner Free](http://www.deepburner.com/) version or other [disk burning tools](http://www.thefreecountry.com/utilities/dvdcdburning.shtml)).

If you are backing up onto several USB memory sticks you may want to set a custom size.

To do this, perform the following steps:

**Step 1. Select** the _Custom size_ (bytes) option, then type the size of the archive in bytes into the text field.

To give you an idea of sizes  
- 1KB (kilobyte) = 1024 bytes - a one-page text document made in Open Office is approximately 20kb  
- 1MB (megabyte) = 1024 KB - a photo taken on a digital camera is usually between 1 - 3 MB  
- 1GB (gigabyte) = 1024 MB - approximately half hour of a DVD quality movie

**Note:** When choosing a custom size to split your backup for a CD or DVD disk, Cobian Backup will not copy the backup to your removable device automatically. Rather, it will create your archive in those files on the computer and you will need to burn them to the CD or DVD disk yourself.

_Password Protect:_ This option lets you enter a password to protect the archive. Simply type, then re-type a password into the two boxes provided. When you try to decompress the archive, you will be asked for the password before the task commences.

**Note:** If you want to secure your archive, you should think about using another method than a password. Cobian Backup lets you encrypt your archive. This is covered below.

_Comment:_ This option lets you write something descriptive about the archive, but it is not a requirement.

### 3.1 How to Decompress Your Backup File

To decompress your backup, perform the following steps:

**Step 1. Select > Tools > Decompressor.**

The Decompressor window appears as follows:
![image](tool_cobian11.png)

**Step 2.** Click on the open file icon to open a browse window to enable you to select the archive you want to decompress.

**Step 3.** Select the archive (_.zip_ or _.7x_ file) and then click "OK".

**Step 4.** Select a directory into which you will unpack (output) the archived file.

**Step 5.** Click on the compression icon to open another window that lets you choose the folder in which to unpack the archive.

**Step 6.** Select a folder, and then click "OK".

Use Windows Explorer to view the files that go to that folder.

### 4.0 About Encryption

Encryption may be a necessity for those wishing to keep their backup secure from unauthorised access. Encryption is the process of encoding, or scrambling, data in such a way that it appears unintelligible to anyone who does not have the specific key needed to decode the message. For more information on encryption, read the [Protecting Files lesson](umbrella://lesson/protecting-files).

### 4.1 How to Encrypt Your Backup File

The _Strong encryption_ pane is used to specify the encryption method to be used.

**Step 1.** Click the _Encryption_ type drop-down box to activate its list of different encryption methods. 

To keep things simple, we recommend that you choose from either the _Blowfish_ or the _Rijndael_ (128 bits) methods. These will provide excellent security for your archive, and let you access the encrypted data with a chosen password.

**Step 2.** Select the _Encryption_ type you want to use.

**Note:** _Rijndael_ and _Blowfish_ both offer approximately the same level of security. _DES_ is weaker but the encryption process is faster.

**Step 3.** Type and re-type the password into the two boxes provided.

The strength of the password is indicated by the bar marked 'Passphrase quality'. The further the bar moves to the right, the stronger the passphrase. Refer to the **[Passwords lesson](umbrella://lesson/passwords)** for information on creating and storing strong passwords.

**Step 4.** Click "OK".

### 4.2 How to Decrypt Your Backup File

Decrypting your backup file is easy and quick. To decrypt your backup file, perform the following steps:

**Step 1. Select > Tools > Decrypter and Keys:**

_This will activate the Decrypter and Keys window as follows:_
![image](tool_cobian12.png)

**Step 2.** Click "Select" to select the archive you want to decrypt.

**Step 3.** Click "Destination" to select the folder in which to store the decrypted archive.

**Step 4.** Select the same encryption type you selected earlier, in section 4.1 How to Encrypt Your Backup File, in the _Methods_ drop-down list.

**Step 4. Select** the appropriate encryption method (the one you used to encrypt your backup file).

**Step 5.** Type your passphrase into the _Passphrase_ text fields.

**Step 6.** Click "Decrypt!"

The file(s) will be decrypted to the location that you specified. If the files were also compressed, you will need to decompress them as outlined in section 3.1 How to Decompress Your Backup.