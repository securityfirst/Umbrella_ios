---
title: VeraCrypt Tool Guide
---
VeraCrypt Tool Guide 
====================

Secure File Storage

**Lesson to read: [Protecting Files](umbrella://lesson/protecting-files)**  
**Level:** Advanced  
**Time required:** 30-60 minutes

**Using VeraCrypt will give you:**

*   The ability to protect your files if your computer or USB storage device gets lost, stolen or confiscated
*   The ability to access and modify the same set of sensitive files on Windows, Mac OS and Linux computers
*   A secure way to backup important files

**Download Location:** [https://www.veracrypt.fr/en/Downloads.html]((https://www.veracrypt.fr/en/Downloads.html))

**Version used in this guide:** 1.16

**License:** Free and Open Source Software

**System Requirements:**
    
GNU/Linux (32-bit and 64-bit versions, kernel 2.6 or compatible)
Apple Mac OS X 10.7 or later, running the latest version of [FUSE for Mac OS] (https://osxfuse.github.io/).
Microsoft Windows Server 2003, 2008, 2012; XP, Vista, 7, 8, 10

Note: Administrator account required for installation and to create volumes


1\. Introduction
================

[**VeraCrypt**](https://www.veracrypt.fr/en/Home.html) is _free software_ that allows you to encrypt your files. It is an updated version of the unmaintained TrueCrypt project and is available for Microsoft Windows, Mac OS and GNU/Linux. It addresses various security vulnerabilities that have since been identified in TrueCrypt.

1.0. Things you should know about VeraCrypt before you start
------------------------------------------------------------

VeraCrypt will protect your files by encrypting them with a passphrase. It creates a protected area, called a _volume_, on your computer or external storage device. This entire volume lives inside a single file called a _container_, which you can open (or _mount_) and close (or _dismount_) using VeraCrypt. You can safely store your files inside this container.

VeraCrypt can also create and manage encrypted volumes that occupy _all_ of the space on a particular storage device. However, this guide focuses on the use of _containers_.

VeraCrypt uses _on-the-fly encryption_ to protect your data. On-the-fly encryption transparently encrypts files as they are being written to a volume and transparently decrypts them as they are being read. You can copy files to and from a VeraCrypt volume in the same way that you would copy them to and from a normal folder or USB storage device.

VeraCrypt supports both _standard encrypted volumes_ and _hidden volumes_. Either one will keep your files confidential, but _hidden volumes_ allow you to hide your important information behind less sensitive data in order to protect it even if you are forced to reveal your VeraCrypt passphrase. This guide covers the creation and use of both _standard volumes_ and _hidden volumes_.

Remember, if you forget your passphrase, you will lose access to your data! There is no way to recover a lost passphrase. Also, keep in mind that the use of encryption is illegal in some jurisdictions.

For more information about VeraCrypt, see:

*   The [official documentation](https://www.veracrypt.fr/en/Documentation.html)
*   The [official FAQ](https://www.veracrypt.fr/en/FAQ.html)

1.1 Other tools like VeraCrypt
------------------------------

Full-featured editions of **Windows** since **Windows 7** contain the **BitLocker** full-disk encryption utility. (This includes Windows 7 Ultimate, Windows 7 Enterprise, Windows 8 Pro, Windows 8 Enterprise and Windows 10 Pro).

For **Mac OS** you can use the built-in **FileVault** utility for full-disk encryption (or to encrypt just your home directory). **Mac OS** also has a **Disk Utility** that can create encrypted volumes on USB storage devices, but you will only be able to access these volumes on a Mac.

Both **FileVault** (for **Mac OS**) and **BitLocker** (for **Windows**) are proprietary software. As a result, the security they provide can not be independently verified. Nonetheless, it is a good idea to enable them if possible. You can use **VeraCrypt**, in addition to these built-in tools, to protect your most sensitive files and to move them between Linux, Mac OS and Windows computers.

Many **GNU Linux** distributions, including [**Ubuntu**](http://www.ubuntu.com/), support full-disk encryption as a standard feature. We recommend enabling full-disk encryption when you install Linux, as it is far easier than doing so later. In addition, you can use the built in **Disk Utility** on most Linux distributions to create an encrypted volume on a USB storage device. Unlike VeraCrypt, however, this will only allow you to access your files on other Linux computers. You can use VeraCrypt to move files between Linux, Mac OS and Windows.

2\. Installing VeraCrypt
========================

To install VeraCrypt on your computer, follow the steps below:

**Step 1**. **Double click** on the installer file named "VeraCrypt Setup 1.16.exe".

![image](tool_veracrypt1.png)

_Figure 1: The VeraCrypt installer_

Note: Mac OS users will be prompted to download [FUSE for Mac OS] (https://osxfuse.github.io/), a software package needed to run VeraCrypt.  

**VeraCrypt** will ask you if you want to allow the installer to make changes to your PC, as shown below.

![image](tool_veracrypt2.png)

_Figure 2: The VeraCrypt User Access Control screen_

**Step 2**. **Click** **\[Yes\]** to run the **VeraCrypt Setup** program, which will activate the _license_ screen

![image](tool_veracrypt3.png)

_Figure 3: The VeraCrypt license_

**Step 3**. **Check** the box labelled _I accept the license terms_ to enable the **\[Next\]** button, then **click** **\[Next\]**. You may then choose whether you want to _install_ VeraCrypt or _extract_ it for use in _portable mode_

![image](tool_veracrypt4.png)

_Figure 4: The installation wizard showing the default Installation mode_

*   _Install_ mode: This option is for users who have no need to hide the fact that **VeraCrypt** is installed on their computer and who are willing to install it on any _other_ computers where they need access to **VeraCrypt**.
*   _Extract_ mode: This option is for users who wish to carry a portable version of **VeraCrypt** on a USB storage device rather than installing it on a computer. The portable version can be run on any Windows computer where the user has an _Administrator_ account.

**IMPORTANT**: Even in portable mode, **VeraCrypt** leaves traces on computers where it is used. These traces will not reveal the contents of encrypted files, but they may reveal the fact that **VeraCrypt** was used on that computer.

**Note**: This section covers _installing_ **VeraCrypt** on your computer. To learn more about using **VeraCrypt** in _portable mode_, see **Portable VeraCrypt,** below.

**Step 4**. **Click** **\[Next\]** and choose where to install **VeraCrypt**.

![image](tool_veracrypt5.png)

_Figure 5: The Setup Options window_

**Step 5**. **Click** **\[Install\]** to begin installing **VeraCrypt** in the default location on your computer as shown below

![image](tool_veracrypt6.png)

_Figure 6: VeraCrypt installer progress_

When it is finished, the installer will let you know

![image](tool_veracrypt7.png)

_Figure 7: VeraCrypt installation successful_

**Step 6**. **Click** **\[OK\]** to acknowledge the completion of the installation and consider making a donation to those who develop and maintain **VeraCrypt**.

![image](tool_veracrypt8.png)

_Figure 8: VeraCrypt donation prompt_

**Step 7** **Click** **\[Finish\]** and consider reading the **VeraCrypt** tutorial.

![image](tool_veracrypt9.png)

_Figure 9: The VeraCrypt tutorial prompt_

**Step 8**. **Click** either button to finish installing **VeraCrypt**. Depending on your installation preferences, you may now have a **VeraCrypt** shortcut on your desktop.

![image](tool_veracrypt10.png)

_Figure 10: The VeraCrypt application shortcut_

**IMPORTANT**: If you do not wish to announce the fact that you have encrypted files on your computer, you might want to delete this shortcut. And, if having encryption software on your computer could get you into _serious_ trouble, you should remove **VeraCrypt** entirely, then extract it onto a USB storage device in _portable mode_ (see below).

**Note**: Users are encouraged to consult the [**VeraCrypt** Beginner's Tutorial](https://www.veracrypt.fr/en/Beginner%27s%20Tutorial.html) after working through this guide.

3\. Creating a standard volume
==============================

**VeraCrypt** lets you create two kinds of encrypted volumes: _Hidden_ volumes and _Standard_ volumes.

*   _Standard volumes_ protect your files with a passphrase that must be entered in order to access them
*   _Hidden volumes_ have _two_ passphrases. You can enter one of them to open a decoy standard volume in which you should store less sensitive files that you are willing to "give up" if necessary. Entering the other passphrase will open the hidden volume containing your truly sensitive files.

In this section, you will learn how to create a **standard** volume. If you want to create a _Hidden volume_, you should complete this section, then continue on to **Creating a hidden volume**, below.

To create a _Standard volume_ with **VeraCrypt**, perform the following steps.

**Step 1**. Launch **VeraCrypt** (**\[Start\]** \> **\[Programs\]** \> **\[VeraCrypt\]** \> **\[VeraCrypt\]**) to open the main application window.

![image](tool_veracrypt11.png)

_Figure 1: The main VeraCrypt window_

**Step 2**. **Click** **\[Create Volume\]** to activate the _VeraCrypt Volume Creation Wizard_

![image](tool_veracrypt12.png)

_Figure 2: Volume Creation Wizard window_

A VeraCrypt container file is an encrypted volume that is stored within a single file. This container can be renamed, moved, copied or deleted like any other file. In this section, we will create a container file. Please refer to the **[VeraCrypt documentation](https://www.veracrypt.fr/en/Documentation.html)** to learn more about the other options.

**Step 3.** **Click** **\[Next\]** to select which type of volume you would like to create.

![image](tool_veracrypt13.png)

_Figure 3: The Volume Type window_

The _VeraCrypt Volume Creation Wizard Volume Type_ window lets you specify whether you want to create a _Standard_ or _Hidden_ volume.

**Note**: Please refer to the **Creating a hidden volume** section for more information about how to create a hidden volume.

**Step 4**. Make sure that _Standard VeraCrypt Volume_ is selected and **click** **\[Next\]** to choose a name and location for your VeraCrypt container file.

![image](tool_veracrypt14.png)

_Figure 4: The Volume Creation Wizard - Volume Location input_

**Step 5**. **Click** **\[Select File…\]** to choose a location.

![image](tool_veracrypt15.png)

_Figure 5: Specify the location and filename of the VeraCrypt container you are about to create_

**Step 6**. Choose a location and specify a name for the **VeraCrypt** _container_ file you are about to create.

You will need to remember where you put it and what you call it. In this section, we will create our _container_ on the **Desktop** and name it **My Volume**. If you want to create a **VeraCrypt** standard volume on a USB storage device instead, simply navigate to the device (rather than to your _Desktop_), and enter a file name.

**Tip**: You can use any file name or file extension for your _container_. For example, you can name your container file _recipes.doc,_ or _holidays.mpg_ in hopes that a casual observer will think it is a _Microsoft Word_ document or a video file. This is one way you can help disguise the existence of a **VeraCrypt** container, but it will not work against someone who has the time and resources to search your device thoroughly.

**Step 7**. **Click** **\[Save\]** to close the _Specify Path and File Name_ window and return to the _Volume Creation Wizard_ window.

![image](tool_veracrypt16.png)

_Figure 6: Volume Creation Wizard displaying the Volume Location window_

**Step 8**. **Click** **\[Next\]** to activate the _Encryption Options_ screen

![image](tool_veracrypt17.png)

_Figure 7: The Volume Creation Wizard Encryption Options window_

Here, you can choose a specific method (or _algorithm_ ) to use when encrypting and decrypting the files stored within your **VeraCrypt** container. _The default options are considered secure,_ so you should probably leave them as they are.

**Step 9**. **Click** **\[Next\]** and determine how large to make your encrypted volume.

![image](tool_veracrypt18.png)

_Figure 8: The Volume Creation Wizard displaying the Volume Size window_

The _Volume Size_ window lets you specify the size of the _container_ you are about to create. In this section, we will create a 250 MB volume, but you might want to specify a different size. Consider the number of files — and, more importantly, the _types_ of files — you intend to store in your encrypted volume. Image files and videos, in particular, can fill up a small **VeraCrypt** container very quickly.

**Tip**: If you think you might want to backup your container file on a CD, you should choose a size that is 700 MB or less. For a DVD backup, it should be 4.5 GB or less. If you intend to upload the container file to an online storage service, you will have to determine a reasonable size based on the speed of your Internet connection.

**Step 10**. **Type** the size of the volume you would like to create. Make sure you select the correct value for **KB** (kilobytes), **MB** (megabytes), **GB** (gigabytes) or **TB** (terabytes). Then **click** **\[Next\]** to choose a passphrase.

![image](tool_veracrypt19.png)

_Figure 9: Volume Creation Wizard featuring the Volume Password window_

**IMPORTANT**: Choosing a strong passphrase is one of the most important steps you will perform when creating a **VeraCrypt** volume. The stronger the passphrase, the better. You don't have to choose your own passphrases (or even remember them!) if you use a _password manager_ like **KeePassXC**. Please refer to the **[Passwords]** (umbrella://lesson/passwords) lesson and [**KeePassXC Tool Guide**](umbrella://lesson/keepassxc) guides to learn more about good passphrase practices.

**Step 11**. **Type** your passphrase and then **re-type** your passphrase into the _Confirm_ field to activate the **\[Next\]** button.

**IMPORTANT**: The button labelled "Next" will remain disabled until the two passphrases you have entered match. If your passphrase is weak, you will see a warning. Consider changing it! Though **VeraCrypt** will accept any passphrase, your data will not be secure unless you choose a strong one.

**Step 12**. **Click** **\[Next\]** to select a file system type.

![image](tool_veracrypt20.png)

_Figure 10: Volume Creation Wizard featuring the Volume Format window_

**Step 13**. **Click** **\[Format\]** to begin creating your standard volume.

**Note:** The default value ("FAT") will work for most people and is compatible with Windows, Mac OS and Linux computers. However, if you intend to store files that are larger than 4 GB (for a single file), then you will have to select a different file system type. **NTFS** will work on **Windows** computers and most Linux computers.

VeraCrypt is now ready to create a _standard encrypted volume within a container file_. If you move your mouse within the _VeraCrypt Volume Creation Wizard_ window, it will produce random data that will help strengthen the encryption.

![image](tool_veracrypt21.png)

_Figure 11: Volume Creation Wizard progress bar_

**VeraCrypt** will now create a file named _My Volume_ on the _Desktop_, as specified above. This file will contain a 250 MB **VeraCrypt** _standard volume container_, which you can use to store your files securely. **VeraCrypt** will let you know when it is done.

![image](tool_veracrypt22.png)

_Figure 12: Volume has been successfully created_

**Step 14**. **Click** **\[OK\]** to acknowledge the completion of the creation process and return to the volume creation wizard.

![image](tool_veracrypt23.png)

_Figure 13: Exit or create another encrypted volume_

**Step 15**. **Click** **\[Exit\]** to close _VeraCrypt Volume Creation Wizard_ and return to the **VeraCrypt's** main window. (If you **click** **\[Next\]**, **VeraCrypt** will begin walking you through the process of creating another encrypted volume.)

You should now see your 250 MB _container_ file wherever you created it.

![image](tool_veracrypt24.png)

_Figure 14: Newly-created VeraCrypt container file on the Desktop_

4\. Creating a hidden volume
============================

In VeraCrypt, a _hidden volume_ is stored within your encrypted _standard volume_, but its existence is concealed. Even when your standard volume is _mounted_, it is not possible to confirm the existence of a hidden volume without its passphrase (which is separate from that of the _standard volume_).

A _hidden volume_ is a bit like a secret compartment in a locked briefcase. You store _decoy_ files that you do not mind having confiscated in the briefcase while keeping your most sensitive files in the secret compartment. The point of a _hidden volume_ is to hide its own existence, thereby hiding the files within it, even if you are forced to reveal the passphrase to your _standard volume_. For this technique to be effective, you must create a situation where the person demanding to see your files will be satisfied by what you show them. To do this, you may want to implement some of the following suggestions:

*   Put some confidential documents that you do not mind having exposed in the standard volume. This information must be sensitive enough that it would make sense for you to keep it in an encrypted volume.
*   Update the files in the standard volume on a regular basis. This will create the impression that you really are using those files.
*   Be aware that someone demanding to see your files may know about the concept of hidden volumes. If you are using VeraCrypt correctly, this person will not be able to _prove_ that your hidden volume exists, but they may _suspect_ it.

As mentioned above, a _hidden volume_ is technically stored inside a _standard volume_. This is why VeraCrypt sometimes refers to them as "inner" and "outer" volumes. Fortunately, you do not have to _mount_ the latter to access the former. Instead, VeraCrypt allows you to create two separate passphrases: one that opens the outer or ("decoy") _standard volume_ one that opens the inner _hidden volume._

**How to a Create a Hidden Volume**

There are two different ways to create a _hidden volume_, and they are both very similar to the process of creating a _standard volume_.

*   **Normal mode** walks you through the process of creating both a _standard volume_ and the _hidden volume_ within it. (You are creating a briefcase with a secret compartment.)
    
*   **Direct mode** assumes that you already have a _standard volume_ in which you want to create a _hidden volume_. (You already have the briefcase, but you want to add the secret compartment.)
    

In this section, we will focus on _direct mode_. If you do not yet have a _standard volume_, simply follow the steps outlined in the **Creating a standard volume** section above, then return to this point.

**Step 1**. Launch VeraCrypt (**\[Start\]** \> **\[All Apps\]** \> **\[VeraCrypt\]** \> **\[VeraCrypt\]**) to open the main application window.

![image](tool_veracrypt25.png)

_Figure 1: The main VeraCrypt window_

**Step 2**. **Click** **\[Create Volume\]** to activate the _VeraCrypt Volume Creation Wizard_.

![image](tool_veracrypt26.png)

_Figure 2: The VeraCrypt Volume Creation screen_

**Step 3**. **Click** **\[Next\]** to accept the default _Create an encrypted file container_ option.

![image](tool_veracrypt27.png)

_Figure 3: Creating a VeraCrypt hidden volume_

**Step 4**. **Check** the **\[Hidden VeraCrypt volume\]** option.

**Step 5**. **Click** **\[Next\]** to choose whether you want to create your _hidden volume_ using _normal mode_ or _direct mode_.

![image](tool_veracrypt28.png)

_Figure 4: The VeraCrypt Volume Creation Wizard - Mode window_

**Step 6**. **Check** the **\[Direct Mode\]** option.

**Step 7**. **Click** **\[Next\]** to select your existing _standard volume_.

![image](tool_veracrypt29.png)

_Figure 5: VeraCrypt's Volume Location screen_

**Note:** Make sure your _standard volume_ is unmounted before selecting it.

**Step 8**. **Click** **\[Select File\]** and locate your _standard volume_ container file.

![image](tool_veracrypt30.png)

_Figure 6: Selecting your existing VeraCrypt standard volume container file_

**Step 9**. **Locate** the container file and select it.

If you want to create a VeraCrypt container on a **USB storage** device, simply navigate to the device (rather than to a folder on your computer) before choosing a file name.

**Step 10**. **Click** **\[Open\]** to return to the _VeraCrypt Volume Creation Wizard_.

![image](tool_veracrypt31.png)

_Figure 7: VeraCrypt standard volume container selected_

**Step 11**. **Click** **\[Next\]** to enter the passphrase of your existing standard volume.

![image](tool_veracrypt32.png)

_Figure 8: VeraCrypt Outer Volume Password screen_

**Step 12**. **Type** in the passphrase you selected when creating the _standard volume_ you have selected.

**Step 13**. **Click** **\[Next\]** to prepare this _standard volume_ for the addition of a _hidden volume_

![image](tool_veracrypt33.png)

_Figure 9: VeraCrypt standard volume prepared_

**Step 14**. **Click** **\[Next\]** to select Hidden Volume Encryption Options.

![image](tool_veracrypt34.png)

_Figure 10: VeraCrypt Hidden Volume Encryption Options screen_

**Step 15**. **Click** **\[Next\]**, and you will be prompted to specify the size of the _Hidden Volume_ you are about to create

**Note**: Leave the default _Encryption Algorithm_ and _Hash Algorithm_ settings for the _Hidden Volume_ as they are.

![image](tool_veracrypt35.png)

_Figure 11: VeraCrypt Hidden Volume Size screen_

As when you created your _standard volume_, consider the number and types of files you intend to store in your _hidden volume._ Image files and videos, in particular, can fill up a small VeraCrypt container very quickly. Also, make sure to leave some space for _decoy_ files in your _standard volume_. If you select the maximum size available for the _Hidden Volume_, you will not be able to put any more files into the existing _standard volume_. (In this section, we will create a 200 MB _hidden volume_ inside a 250 MB _standard volume._ This will leave approximately 50 MB of space for _decoy_ files.)

**Step 16**. **Type** the size of the volume you would like to create. Make sure you select the correct value for **KB** (kilobytes), **MB** (megabytes), **GB** (gigabytes) or **TB** (terabytes).

**Step 17**. **Click** **\[Next\]** to choose a passphrase for your _hidden volume_.

![image](tool_veracrypt36.png)

_Figure 12: VeraCrypt Hidden Volume Password creation screen_

You must now choose a passphrase for the _hidden volume_ that is _different_ from the one you chose for your _standard volume_. Again, remember to choose a strong passphrase. Please refer to the **[Passwords]** (umbrella://lesson/passwords) lesson to learn more.

**Tip**: If you use a _password manager_ such as **KeePassXC** and are concerned about being pressured to reveal the contents of your **VeraCrypt** container, you can store the passphrase for your (decoy) _standard volume_ in **KeePassXC**, but you should memorise the passphrase for your _hidden volume._ Otherwise, by handing over your **KeePassXC** passphrase, you will also reveal your _hidden volume_ passphrase.

**Step 18**. **Choose** a passphrase and **type** it in twice.

**Step 19**. **Click** **\[Next\]** to activate the _Hidden Volume Format_ screen.

![image](tool_veracrypt37.png)

_Figure 13: VeraCrypt Hidden Volume Format screen_

**Step 20**. **Click** **\[Format\]** to format the hidden volume.

**Note:** The default value ("FAT") will work for most people and is compatible with Windows, Mac OS and Linux computers. However, if you intend to store files that are larger than 4 GB (for a single file), then you will have to select a different file system type. **NTFS** will work on Windows computers and most Linux computers.

**VeraCrypt** is now ready to create a _standard encrypted volume within a container file_. If you move your mouse within the _VeraCrypt Volume Creation Wizard_ window, it will produce random data that will help strengthen the encryption.

![image](tool_veracrypt38.png)

_Figure 14: VeraCrypt Hidden Volume Format progress_

When VeraCrypt is done, it will display a warning about protecting the files in your _hidden volume_ when adding content to your _standard volume_.

![image](tool_veracrypt39.png)

_Figure 15: The VeraCrypt Hidden Volume protection warning message_

**IMPORTANT**: This warning is related to how VeraCrypt hides the existence of your (inner) _hidden volume_. Normally, when you open your (outer) _standard volume_, both VeraCrypt and Windows will _think_ that it occupies all of the space available within your encrypted _container_ file. About 250 MB in this example. (In fact, we created a 200 MB _hidden volume_ and left only about 50 MB for decoy files in our _standard volume_.) VeraCrypt can not warn you if you try to copy a 60 MB file into that 50 MB _standard volume_. This is because, if it _did_ warn you, it would reveal to an observer that you had reserved space for a _hidden volume_. Instead, it will allow you to copy that 60 MB file. And, by doing so, _it will delete or corrupt the files inside your hidden volume._

In other words, this design is based on the assumption that you would rather _lose_ the contents of your _hidden volume_ than reveal their existence.

So, whenever you want to add decoy files to your standard volume, you must check the _protect hidden volume against damage..._ box and enter both your _hidden volume_ passphrase and your _standard volume_ passphrase. If you enable this feature, VeraCrypt _will_ be able to warn you if you try to copy too much data into your outer volume. (Clearly, entering both passphrases in front of someone else will reveal the existence of your _hidden volume_, so this is something you should only do in private or in the company of those you trust.)

The specific steps required to modify the contents of your _standard volume_ are covered in more detail in the section below, **Protecting your hidden volume when modifying the contents of your outer volume**.

**Step 21**. **Click** **\[OK\]** to finish creating your _hidden volume_.

![image](tool_veracrypt40.png)

_Figure 16: The VeraCrypt Hidden Volume Created screen_

**Step 22**. **Click** **\[OK\]** to return to the main VeraCrypt window.

You can now store files in your _hidden volume_. They will remain undetectable even to someone who has obtained the passphrase for your _standard volume_.

5\. Using your VeraCrypt volume
===============================

This section of this guide explains how to use standard and hidden VeraCrypt volumes on Windows.

5.1. Mounting a volume
----------------------

In VeraCrypt, to _mount_ a volume is to make it available for use. When you successfully mount a volume it appears as if you have attached a portable storage device to your computer. You can use this disk as usual to access, create, modify or delete files and folders. When you are done using it, you can dismount it and the new disk will disappear. You mount a hidden volume the same way as a standard volume. Depending on which passphrase you enter, VeraCrypt will determine whether to mount the standard or hidden volume.

To mount your volume, perform the following steps:

**Step 1.** Launch VeraCrypt (**Start** \> **All Apps** \> **VeraCrypt** \> **VeraCrypt**) to open the main application window

**Step 2.** **Select** a drive from the list in the main window of **VeraCrypt**

![image](tool_veracrypt41.png)

_Figure 1: The main window of VeraCrypt with an available drive selected_

**Note**: In _Figure 1_, we have chosen to mount our encrypted volume on drive _F:_. You may choose any of the drive letters shown each time you mount a volume.

**Step 3.** **Click** **\[Select File…\]** and locate your VeraCrypt _container_ file

![image](tool_veracrypt42.png)

_Figure 2: The Select a VeraCrypt Volume screen_

**Step 4.** **Select** the _container_ file you want to mount, then **click** **\[Open\]** to return to the **VeraCrypt** main window. The location of your _container_ file will be displayed just to the left of the **\[Select File...\]** button you clicked earlier.

![image](tool_veracrypt43.png)

_Figure 3: The main window of VeraCrypt with a container selected_

**Step 5.** **Click** **\[Mount\]** to enter your passphrase

![image](tool_veracrypt45.png)

_Figure 4: The Enter Password screen_

**Step 6.** **Type** your passphrase in the _Password_ box.

If your _container_ holds a hidden volume, choose one of the options below:

*   To open a _hidden volume_, enter your _hidden volume_ passphrase
    
*   To open a _standard volume_ in a _container_ that holds a _hidden volume_ — _while being observed by someone from whom you would like to hide the existence of that volume_ — enter your _standard volume_ passphrase
    
*   To open a _standard volume_ in a _container_ that holds a _hidden volume_ — _in order to modify your "decoy" files while not being observed_ — please read, **Protecting your hidden volume when modifying the contents of its outer volume.**
    

**Step 7.** **Click** **\[OK\]** to begin mounting the _standard volume_.

If the passphrase you entered is incorrect, **VeraCrypt** will prompt you to enter it again. If it is correct, your encrypted volume will be mounted as follows:

![image](tool_veracrypt44.png)

_Figure 5: The VeraCrypt main window displaying the newly mounted volume_

**Step 8.** Enter the mounted volume

There are two ways to enter a mounted volume:

1.  **Double click** the highlighted entry in the main window of **VeraCrypt** as shown in _Figure 5_, above
2.  **Double click** the corresponding drive letter (here, we are using _F:_) within _This PC_, as shown in _Figure 6_, below

![image](tool_veracrypt46.png)

_Figure 6: Accessing the VeraCrypt volume through "This PC"_

The volume shown below is empty. Once you have stored files there, they will be accessible (and editable) whenever you open the volume.

![image](tool_veracrypt47.png)

_Figure 7: Inside the mounted VeraCrypt volume_

This virtual disk behaves like an external storage device, except that it is fully encrypted. You can copy files to and from it just like you would for a USB storage device. By dragging and dropping them, for example, or by saving them directly to the volume from within another application. Files are automatically encrypted when you copy, move or save them to this virtual disk. And, when you move a file _out_ of the VeraCrypt volume, it is automatically decrypted. If your computer is shutdown or switched off suddenly, the encrypted volume will remain inaccessible until it is mounted again.

**IMPORTANT:** While your VeraCrypt volume is mounted, the files inside are not protected and are freely accessible to anyone with access to your computer. To protect your sensitive files, you must dismount your VeraCrypt volume when you are not using it. Keep this in mind when you step away from your computer and in circumstances where you face an increased risk of confiscation or theft. Leaving your encrypted volumes mounted is like owning a safe and leaving the door wide open. If you shut down, restart or switch off your computer, your encrypted volume will be inaccessible until it is mounted again. You might want to practice doing one of these things as quickly as possible.

**Tip:** Merely closing the main window by clicking **\[Exit\]** is not enough to quit the application completely.

5.2. Dismounting a volume
-------------------------

In VeraCrypt, to dismount a volume is to make it unavailable for use. To dismount a volume and ensure that nobody can access the files within it unless they know the appropriate passphrase, perform the following steps:

**Step 1**. **Select** the volume from the list of mounted volumes in the main **VeraCrypt** window

![image](tool_veracrypt48.png)

_Figure 1: Selecting the Standard Volume to be dismounted_

**Step 2**. **Click** **\[Dismount\]** to dismount the **VeraCrypt** volume.

To retrieve a file stored in your standard volume once you have closed or dismounted it, you will have to mount it again.

**IMPORTANT**: Make sure to dismount your **VeraCrypt** volume before:

*   Removing the external USB storage device on which your _container_ is stored (if you have chosen to keep it on one)
*   Putting your computer into _Standby_ or _Hibernate_ mode
*   Leaving your computer unattended
*   Entering a situation in which your computer is more likely than usual to be lost, stolen or confiscated

**Step 3**. **Right click** the **VeraCrypt** _System Tray_ icon — in the lower, right-hand corner of your Windows desktop — and select **\[Exit\]** in order to quit **VeraCrypt** completely.

![image](tool_veracrypt49.png)

_Figure 2: Quitting VeraCrypt cleanly with the System Tray icon_

**Tip**. When using the installed version of **VeraCrypt** (as opposed to the portable version), merely closing the _main window_ by clicking **\[Exit\]** is not enough to exit the application completely.

5.3. Protecting your hidden volume when modifying the contents of its outer volume
----------------------------------------------------------------------------------

As discussed under **Creating a hidden volume**, when you mount a **VeraCrypt** volume, you can choose to _Protect hidden volume against damage caused by writing to outer volume_. This allows you to add new "decoy" files to your standard volume without the risk of accidentally deleting or corrupting the contents of your hidden volume. You should not activate the _Protect hidden volume_ feature when trying to hide the existence of your _hidden volume_ from someone who is forcing you to enter your decoy passphrase, however, because doing so requires that you enter _both_ of your passphrases (which is a pretty clear indication that you have a _hidden volume_ in there somewhere).

When updating your decoy files in private, however, you should _always_ enable this feature. And don't worry, _the box will uncheck itself automatically after you dismount the volume._

To use the _Protect hidden volume_ feature, perform the following steps:

**Step 1**. **Select** a drive from the list in the main window of **VeraCrypt**

![image](tool_veracrypt50.png)

_Figure 1: The main window of VeraCrypt with an available drive selected_

**Note**: In _Figure 1_, we have chosen to mount our encrypted volume on drive _F:_. You may choose any of the drive letters shown each time you mount a volume.

**Step 2**. **Click** **\[Select File…\]** and locate your VeraCrypt _container_ file

![image](tool_veracrypt51.png)

_Figure 2: The Select a VeraCrypt Volume screen_

**Step 3**. **Select** the _container_ file you want to mount, then **click** **\[Open\]** to return to the **VeraCrypt** main window. The location of your _container_ file will be displayed just to the left of the **\[Select File...\]** button you clicked earlier.

![image](tool_veracrypt52.png)

_Figure 3: The main window of VeraCrypt with a container selected_

**Step 4**. **Click** **\[Mount\]** to open the _Enter Password_ screen

![image](tool_veracrypt53.png)

_Figure 4: The Enter Password screen_

**Step 5.** **Type** your **outer volume** passphrase in the _Password_ box, as if you were going to mount it normally, **but do not click \[OK\]**

**Step 6.** **Click** **\[Mount Options...\]**, which will allow you to protect your _hidden volume_ while modifying the contents of your _standard volume_

![image](tool_veracrypt54.png)

_Figure 5: VeraCrypt's Mount Options screen_

**Step 7.** **Check** the box labelled _Protect hidden volume against damage caused by writing to outer volume_

**Step 8.** **Type** your _hidden volume_ passphrase where indicated

**Step 9.** **Click** **\[OK\]** to return to the password prompt

![image](tool_veracrypt55.png)

_Figure 6: VeraCrypt's Enter Password screen with the hidden volume protected_

**Step 10.** **Click** **\[OK\]** to mount your _standard volume_ while protecting your _hidden volume_ from accidental damage. VeraCrypt will let you know when it's done.

![image](tool_veracrypt56.png)

_Figure 7: VeraCrypt's "Hidden volume is now protected" screen_

**Step 11.** **Click** **\[OK\]** to return to the main VeraCrypt window

![image](tool_veracrypt57.png)

_Figure 8: VeraCrypt's "Hidden volume is now protected" screen_

**Step 12.** Enter the mounted volume

As when mounting a volume normally, there are two ways to enter a mounted volume:

1.  **Double click** the highlighted entry in the main window of **VeraCrypt** as shown in _Figure 8_, above
2.  **Double click** the corresponding drive letter (here, we are using _F:_) within _This PC_

The volume shown below is empty. But, once you have stored "decoy" files in your _standard volume_, they will be accessible whenever you mount it. And, if you have protected your _hidden volume_ with the steps above, you will be able to add or modify files.

![image](tool_veracrypt58.png)

_Figure 9: Inside the mounted VeraCrypt standard volume with a protected hidden volume_

**When you are done modifying the contents of your standard volume, you can dismount it by following the usual steps**, which are described under **Dismounting a volume**, above. And, the next time you go to mount a volume, the _Protect hidden volume against damage caused by writing to outer volume_ box will be _unchecked_ by default.

6\. Managing your VeraCrypt container
=====================================

6.1. Importing content from a TrueCrypt volume
----------------------------------------------

**VeraCrypt** can mount **TrueCrypt** volumes. Given that **TrueCrypt** is no longer maintained, however, you should move your files to a **VeraCrypt** volume as soon as possible. The easiest way to do this is to:

1.  Create a new **VeraCrypt** volume as large as (or larger than) your existing **TrueCrypt** volume,
2.  Open both volumes at the same time, and
3.  Copy everything from the **TrueCrypt** volume to the **VeraCrypt** volume

For the first item, above, see **Creating a standard volume** (and, if appropriate, **Creating a hidden volume**. This section assumes that you already have one or more appropriately sized **VeraCrypt** volumes. The steps below address the process of moving files from a **TrueCrypt** _standard volume_ to a **VeraCrypt** _standard volume_ that has already been mounted. If you have files in _both_ the _standard_ and _hidden_ volumes of a **TrueCrypt** container, simply make sure that your **VeraCrypt** volumes are large enough, then work through the following steps twice — once for each volume.

With the **VeraCrypt** _main window_ open, and your new **VeraCrypt** volume mounted, carry out the following steps:

![image](tool_veracrypt59.png)

_Figure 1: VeraCrypt's main window showing a mounted volume_

**Step 1**. **Click** a drive letter that is not already taken by a mounted **VeraCrypt** volume

**Step 2**. **Click** **\[Select File...\]** to choose your **TrueCrypt** container

![image](tool_veracrypt60.png)

_Figure 2: Choosing a TrueCrypt container_

**Step 3**. **Navigate** to your **TrueCrypt** container

**Step 4**. **Click** **\[Open\]** to return to the _main window_

![image](tool_veracrypt61.png)

_Figure 3: VeraCrypt's main window with a TrueCrypt container selected_

**Step 5**. **Click** **\[Mount\]** to enter the passphrase for your **TrueCrypt** volume

![image](tool_veracrypt62.png)

_Figure 4: The VeraCrypt password screen in TrueCrypt mode_

**Step 6**. **Check** the **TrueCrypt Mode** box

**Step 7**. **Type** the passphrase for your TrueCrypt volume

**Step 8**. **Click** **\[OK\]** to return to the _main window_

![image](tool_veracrypt63.png)

_Figure 5: VeraCrypt's main window with both volumes mounted_

**Step 9**. **Double click** the drive letter for your mounted **TrueCrypt** volume to enter it

![image](tool_veracrypt64.png)

_Figure 6: Inside the mounted TrueCrypt volume_

**Step 10**. Return to the _main window_

![image](tool_veracrypt65.png)

_Figure 7: VeraCrypt's main window with both volumes mounted_

**Step 11**. **Double click** the drive letter for your mounted **VeraCrypt** container to enter it

![image](tool_veracrypt66.png)

_Figure 8: TrueCrypt and VeraCrypt volumes mounted and displayed side-by-side_

**Step 12**. **Select** the contents of your **TrueCrypt** volume and drag them to window representing your **VeraCrypt** volume.

![image](tool_veracrypt67.png)

_Figure 9: Contents of a TrueCrypt volume copied to a VeraCrypt volume_

After your files have been copied over, you should _dismount_ both volumes.

**Step 13**. Return to **VeraCrypt's** _main window_

![image](tool_veracrypt68.png)

_Figure 10: VeraCrypt's main window_

**Step 14**. **Select** the drive letter for your mounted **TrueCrypt** volume

**Step 15**. **Click** **\[Dismount\]** to dismount your **TrueCrypt** volume

![image](tool_veracrypt69.png)

_Figure 11: VeraCrypt's main window_

**Step 16**. **Select** the drive letter for your mounted **VeraCrypt** volume

**Step 17**. **Click** **\[Dismount\]** to dismount your **VeraCrypt** volume

6.2. Changing one or both passphrases for a container
-----------------------------------------------------

To change the passphrase of a **VeraCrypt** _volume_, start from the _main screen_ and follow the steps below. These steps apply to both _standard volumes_ and _hidden volumes_ within **VeraCrypt** _containers_. However, if you want to change _both_ passphrases, you will need to go through this process twice.

![image](tool_veracrypt70.png)

_Figure 1: VeraCrypt's main window_

**Step 1**. **Click** **\[Select File...\]** to choose the _container_ for which you want to change the passphrase

![image](tool_veracrypt71.png)

_Figure 2: Selecting a container file in VeraCrypt_

**Step 2**. **Select** your **VeraCrypt** _container_

**Step 3**. **Click** **\[Open\]** to return to the _main window_

![image](tool_veracrypt72.png)

_Figure 3: VeraCrypt's main window_

**Step 4**. **Click** **\[Volumes\]**

**Step 5**. **Select** **\[Change Volume Password...\]** as shown below

![image](tool_veracrypt73.png)

_Figure 4: Changing the passphrase of a VeraCrypt volume_

This will activate the **Change Password** screen

![image](tool_veracrypt74.png)

_Figure 5: VeraCrypt's Change Password screen_

**Tip:** If you have both a standard volume and a hidden volume in this container, VeraCrypt will automatically determine which password to change based on what you enter in the **\[Current Password\]** field. If you want to change both passwords, you will need to go through this process twice.

**Step 6**. **Type** your current passphrase

**Step 7**. **Type** your new passphrase twice

**Step 8**. **Click** **\[OK\]** to begin generating a new key.

**Note:** Older versions of VeraCrypt may display a warning about your "Personal Iterations Multiplier (PIM)" value even though you have chosen a strong passphrase. If you see this warning, double check that your passphrase is longer than 20 characters and that the Use PIM box is unchecked. Then click \[Yes\] to continue.

![image](tool_veracrypt75.png)

_Figure 6: VeraCrypt password change progress bar_

When it is ready, **VeraCrypt** will display the _Random Pool Enrichment_ screen.

![image](tool_veracrypt76.png)

_Figure 7: VeraCrypt's Random Pool Enrichment screen_

**Tip:** By moving your mouse around within the _Random Pool Enrichment_ screen, you can increase the strength of the encryption that **VeraCrypt** provides.

**Step 9**. **Click** **\[Continue\]** to continue the process of changing your passphrase.

![image](tool_veracrypt77.png)

_Figure 8: VeraCrypt's password change progress bar_

**VeraCrypt** will let you know when it is done generating a new key for your encrypted volume

![image](tool_veracrypt78.png)

_Figure 9: VeraCrypt passphrase successfully changed_

**Step 10**. **Click** **\[OK\]** to complete the process of changing your passphrase

**IMPORTANT:** Changing your passphrase does not change the actual encryption key used to protect your data. Practically, this means that anyone with the following three things may be able to access the files in your VeraCrypt container _even after you have changed its passphrase_:

*   A copy of your "old" VeraCrypt container (from _before_ you changed the passphrase)
*   The passphrase to that old VeraCrypt container
*   A copy of your "new" VeraCrypt container (from _after_ you changed the passphrase)

So, **if you suspect that someone might have both a copy of your container and knowledge of its passphrase, you should do more than just change your passphrase**. You should instead generate an entirely new container (with a new passphrase), then copy over your files and delete the old container.

7\. Portable VeraCrypt
======================

7.1. Differences between the installed and portable versions of VeraCrypt
-------------------------------------------------------------------------

By extracting **VeraCrypt** in _portable mode_, you can use it to protect your sensitive files without installing the software on your computer in the usual way. In some situations, this approach might help you hide the fact that you use **VeraCrypt** at all. This, in turn, will make it less apparent that you are storing encrypted data.

If you extract the portable version of **VeraCrypt** onto a USB storage device, along with your encrypted _container_ file, you will be able to access your files on almost Windows computer. Keep in mind, however, that your external storage devices are only as safe as the computers to which you attach them. Indiscriminately decrypting your sensitive files on unfamiliar hardware can expose you to malware capable of reading the contents of your _encrypted volume_ while it is "open" (or even capturing your **VeraCrypt** passphrase when you enter it).

There are very few differences between the installed and portable versions of **VeraCrypt**, the most significant being that the portable version does not allow you to encrypt your system disk. It works best with encrypted _container_ files.

7.2. Extracting the portable version of VeraCrypt
-------------------------------------------------

**Note**: You must create the folder into which you will extract the portable version of **VeraCrypt** — typically on a USB storage device or somewhere on your hard drive — before you extract it

**Step 1**. **Navigate** to the location where you would like to extract the portable version of **VeraCrypt**

**Step 2**. **Right-click** to activate its contextual menu.

**Step 3**. **Select** the _New_ menu item, then **select** the _Folder_ sub-menu item, as shown below

![image](tool_veracrypt79.png)

_Figure 1: Creating a folder on Windows_

**Step 4**. **Type** a name for the folder into which you are about to extract **VeraCrypt**

**Step 5**. **Press** _Enter_ to finish naming the new folder

![image](tool_veracrypt80.png)

_Figure 2: Naming a folder on Windows_

**Step 6**. **Double-click** the **VeraCrypt** installer to open the installation screen

![image](tool_veracrypt81.png)

_Figure 3: The VeraCrypt installer_

**Step 7**. **Double-click** the **VeraCrypt** installer to activate the User Account Control screen

![image](tool_veracrypt82.png)

_Figure 4: The VeraCrypt User Account Control screen_

**Step 8**. **Click** **\[Yes\]** to load the license screen

![image](tool_veracrypt83.png)

_Figure 5: The VeraCrypt license screen_

**Step 9**. **Click** _I accept the license terms_

**Step 10**. **Click** **\[Next\]** to activate the installer

![image](tool_veracrypt84.png)

_Figure 6: The main VeraCrypt installation screen_

**Step 11**. **Select** _Extract_

**Step 12**. **Click** **\[Next\]** to activate the driver warning screen

The two warning screens below are just VeraCrypt's way of telling you that you will have to dismiss a _User Account Control_ (UAC) screen _every time you launch the portable version_ of **VeraCrypt**. (You will not have to do this if you install the software normally.)

![image](tool_veracrypt85.png)

_Figure 7: A message related to how the portable version of VeraCrypt installs Windows drivers_

**Step 13**. **Click** **\[OK\]** to activate yet another driver-related warning screen

![image](tool_veracrypt86.png)

_Figure 8: A warning about the need to acknowledge a User Account Control warning when starting the portable version of VeraCrypt_

**Step 14**. **Click** **\[Yes\]** to begin choosing your extraction location

![image](tool_veracrypt87.png)

_Figure 9: The Extraction Options screen_

**Step 15**. **Click** **\[Browse\]** to choose your extraction location

![image](tool_veracrypt88.png)

_Figure 10: Choosing where to extract the portable version of VeraCrypt_

In this guide, we will extract the portable version of **VeraCrypt** into the "VCP" folder that we created in _Step 1_. This folder is located inside the a USB storage device called "USB Storage (D:)".

**Step 16**. Locate and select the folder inside which you would like to extract the portable version of **VeraCrypt**.

**Step 17**. **Click** **\[OK\]** to return to the _Extraction Options_ screen

![image](tool_veracrypt89.png)

_Figure 11: The Extraction Options screen after choosing a location_

**Step 18**. **Click** **\[Extract\]** to begin extracting **VeraCrypt**. The **VeraCrypt** installer will let you know when it is done.

![image](tool_veracrypt90.png)

_Figure 12: The file extraction progress screen_

![image](tool_veracrypt91.png)

_Figure 13: The portable version of VeraCrypt successfully extracted_

**Step 19**. **Click** **\[OK\]** to activate the donation prompt

![image](tool_veracrypt92.png)

_Figure 14: VeraCrypt donation prompt_

**Step 20**. **Click** **\[Finish\]** to complete the extraction of the portable version of **VeraCrypt**

**IMPORTANT**: If you have extracted the portable version of **VeraCrypt** to a USB storage device in order to hide the fact that you are using it on your computer, be sure to **delete the installer** from your computer.

7.3. Launching the portable version of VeraCrypt
------------------------------------------------

**Step 1**. **Navigate** to the folder where you extracted the portable version of **VeraCrypt**

**Step 2**. **Double click** either the **VeraCrypt** file (_Figure 1_, below) or the **VeraCrypt-x64** file (_Figure 2_), depending on whether your Windows system is 32 bit or 64 bit

![image](tool_veracrypt93.png)

_Figure 1: The 32 bit portable VeraCrypt launcher_

![image](tool_veracrypt94.png)

_Figure 2: The 64 bit portable VeraCrypt launcher_

This will activate the **VeraCrypt** _User Account Control_ window

![image](tool_veracrypt95.png)

_Figure 2: The VeraCrypt User Account Control screen_

**Step 3**. **Click** **\[Yes\]** to launch the portable version of **VeraCrypt**

![image](tool_veracrypt96.png)

_Figure 3: The main VeraCrypt window_

You can now use **VeraCrypt**, as usual, to create, manage, mount and dismount _encrypted volumes_. When you quit the portable version of **VeraCrypt**, it will unload its Windows drivers and exit cleanly. **If you are running the portable version of VeraCrypt from a USB storage device, make sure you close your open volumes and exit the program before ejecting and removing the storage device.**

**Tip:** In order to exit completely from the _installed_ version of **VeraCrypt** — even after you have have clicked **\[Exit\]** to close the main window — you have to right-click on the _System Tray_ icon and select **\[Exit\]**. The portable version does not require this additional step.

FAQ
===

**_Q_**: Am I going to have to spend all my time typing passphrases into **VeraCrypt**?

**_A_**: No, you only need to enter your passphrase once to open an encrypted volume. After that, you can access your files without a passphrase until you close the volume

**_Q_**: Can I uninstall **VeraCrypt** if I don't want it any more? If I do, will my files remain encrypted?

**_A_**: Yes. You can uninstall **VeraCrypt** by opening _Terminal_, typing `sudo veracrypt-uninstall.sh` and entering the passphrase you use to login to your computer. You can later reinstall **VeraCrypt** to access the files in your containers, which will remain encrypted and will not be deleted when you remove **VeraCrypt**. Similarly, if you transfer your encrypted _container file_ another computer, you will need your passphrase and the **VeraCrypt** program to open it.

**_Q_**: What kinds of information require encryption?

**_A_**: Ideally, you should encrypt all your documents, pictures and any other files that contain private and sensitive information. And, if your operating system supports it, you should configure _full disk encryption_ so that _all_ of your files are encrypted whenever your computer is turned off

**_Q_**: How secure will my files be?

**_A_**: **VeraCrypt** has been independently tested and reviewed by security experts to verify how well it performs and to determine whether or not it provides all of the functions it claims to support. The results suggest that **VeraCrypt** offers a very high level of protection. However, choosing a strong passphrase is essential to the security of your data.

**_Q_**: Why would I use a _hidden volume_?

**_A_**: **VeraCrypt's** _standard volumes_ protect your files with strong encryption. _Hidden volumes_, which provide the same level of encryption, are designed to give you more options if someone demands your **VeraCrypt** passphrase. Rather than giving up your _hidden volume_ passphrase, you can give up your _standard volume_ passphrase. If asked, you can deny that you have a _hidden volume_. To use this feature properly, however, you will a strong grasp of your own security environment, a good understanding of how **VeraCrypt** works and a convincing set of "decoy" files in your _standard volume_.

**_Q_**: How do I mount my original _standard volume_, rather than the one that's hidden?

**_A_**: It all depends on which passphrase you enter in the password screen. If you enter the _standard volume_ passphrase, **VeraCrypt** will mount the _standard volume_. If you enter the _hidden volume_ passphrase, **VeraCrypt** will mount the _hidden volume_. That way, if someone demands that you open your **VeraCrypt** container, you can mount the _standard volume_ and deny the existence of a _hidden volume_. Under the right circumstances, this might be enough to get you off the hook and out of trouble.

**_Q_**: Is it possible to inadvertently damage or delete a _hidden volume_?

**_A_**: Yes. If you continue adding files to your _standard volume_ until you run out of space for your hidden volume, your _hidden volume_ will be damaged or destroyed. There is an option when you mount the standard volume that you can use to protect your _hidden volume_ from being damaged when modifying the contents of your _standard volume_. You should not use this option while being observed, as it reveals the existence of a _hidden volume_.

**_Q_**: Can I change the size of a VeraCrypt volume after creating it?

**_A_**: No. You will have to create a new container with a larger volume, then move your files form the old volume to the new one. You can do this by mounting both volumes at the same time. This applies to both standard and hidden volumes.

**_Q_**: Can I use tools like **chkdsk** on the contents of a mounted **VeraCrypt** volume?

**_A_**: **VeraCrypt** volumes behave like normal storage devices, so it is possible to use any file system checking/repairing/defragmenting tools on the contents of any mounted **VeraCrypt** volume.

**_Q_**: Is it possible to change the passphrase for a _hidden volume_?

**_A_**: Yes. The passphrase change feature applies to both _standard_ and _hidden volumes_. Just type the passphrase for the _hidden volume_ into the Current Password field of the Password Change screen.

*   [**Official VeraCrypt FAQ**](https://www.veracrypt.fr/en/FAQ.html)