---
title: Mailvelope
---
Mailvelope  
====================

Secure Webmail 

**Lesson to read: [Protecting Files](umbrella://lesson/protecting-files), [Email](umbrella://lesson/email)**  
**Level:** Advanced  
**Time required:** 30-60 minutes  
**Updated:** April 2018  (some images date from earlier versions)  
**Sources:** Security in a Box, [MAILVELOPE - OPENPGP ENCRYPTION FOR WEBMAIL] (https://securityinabox.org/en/guide/mailvelope/web/).

**Using Mailvelope will give you:**

- The ability to send and receive end-to-end encrypt email that can not be read by third parties.
- The ability to sign your email digitally and authenticate signed email from others.


**Download Location:** [https://www.mailvelope.com/en]((https://www.mailvelope.com/en))  
**Version used in this guide:** 1.5.1  
**License:** Free and Open Source Software  
**System Requirements:**  **Mozilla Firefox,** **Google Chrome** or **Chromium** running on LINUX, Windows or Mac. 




# 1. Introduction 

Mailvelope is a browser extension that allows you to encrypt, decrypt, sign and authenticate email messages and files using OpenPGP. (A browser extension is a software component that adds additional features to your web browser.) It works with webmail and does not require you to download or install additional software. While Mailvelope lacks many of the features provided by Thunderbird, Enigmail and GnuPG, it is probably the easiest way for webmail users to begin taking advantage of end-to-end encryption.

## 1.0 Things you should know about Mailvelope before you start

Mailvelope relies on a form of *public-key cryptography* that requires each user to generate her own pair of *keys*. This *key pair* can be used to encrypt, decrypt and sign digital content such as email messages. It includes a *private key* and a *public key*: 

- Your **private key** is extremely sensitive. Anyone who managed to obtain a copy of this key would be able to read encrypted content that was meant only for you. They could also sign messages so they appeared to have *come from* you. Your *private key* is, itself, encrypted to a passphrase that you will choose when generating your *key pair*. You should choose a strong passphrase and take care not to let anyone gain access to your *private key*. You will use your *private key* to decrypt messages sent to you by those who have a copy of your *public key*.
 
- Your **public key** is meant to be shared with others and can not be used to read an encrypted message or fake a signed one. Once you have a correspondent’s public key, you can begin sending her encrypted messages. Only she will be able to decrypt and read these messages because only she has access to the *private key* that matches the *public key* you are using to encrypt them. Similarly, in order for someone to send *you* encrypted email, they must obtain a copy of your *public key*. It is important to verify that the *public key* you are using to encrypt email actually does belong to the person with whom you are trying to communicate. If you or your correspondent are tricked into encrypting email with the wrong public key, your conversation will not be secure.

Mailvelope also lets you attach **digital signatures** to your messages. If you *sign* a message using your *private key*, any recipient with a copy of your *public key* can verify that it was sent by you and that its content was not tampered with. Similarly, if you have a correspondent's *public key*, you can verify his digital signatures.

Mailvelope lets you: 

- Generate an encryption key pair
- Export your public key so you can share it with others
- Import other people's public keys
- Compose, encrypt and sign email messages
- Decrypt and authenticate messages 
- Encrypt, attach and decrypt files

Your correspondents do not have to use Mailvelope, but they do have to use some form of OpenPGP encryption, several of which are listed below.

Since Mailvelope is a browser extension, it will only work with the browser on which it was installed. If you want to use Mailvelope with a different browser, you will have to install it again. This is true even if both browsers are on the same computer. You will also have to export all of your keys and import them into the new copy of Mailvelope.


## 1.1 Other tools like Mailvelope

Because Mailvelope is a browser extension, it works on most desktop operating systems. This includes GNU/Linux, Microsoft Windows and Mac OS X. It does not work on Android or iOS mobile devices. Below are a few free and open source alternatives: 

- [**Thunderbird with Enigmail**](../../thunderbird/windows) complete email client with PGP encryption added for GNU/Linux, Microsoft Windows and Mac OS X
- [**GPG4Win**](https://www.gpg4win.org/) PGP email and files encryption tools suite for Microsoft Windows
- [**GPG Tools Suite**](https://gpgtools.org/) for Mac OS X
- [**gpg4usb**](https://www.gpg4usb.org/) standalone, portable PGP tool for GNU/Linux and Microsoft Windows
- [**Mailpile**](https://www.mailpile.is/) An upcoming, OpenPGP-compatible mail client for GNU/Linux, Microsoft Windows and Mac OS X


# 2. Generate and share encryption keys

Before you can begin encrypting and decrypting email, you must take three preparatory steps:

- Generate your encryption key pair (or import it if you already have one)
- Export your public key and send it to your contacts
- Import public keys from your contacts


## 2.1 Generate a key pair

To generate your key pair, open the browser where you installed Mailvelope and follow the steps below.

**Step 1**. **Click** the Mailvelope **lock icon** in your browser toolbar to activate the following screen:

![](mailvelope-all-en-v01-002.png)

**Step 2**. **Click** **[Options]** to activate the Mailvelope *Options* screen

![](mailvelope-all-en-v01-003.png)

**Step 3**. **Click** **[Generate key]** and **type** your information into the fields, as shown below:

![](mailvelope-all-en-v01-004.png)

**Important:** 

- Choose a strong passphrase to protect your private key. (Learn how to create strong [Passwords](umbrella://lesson/passwords/0).)
- You do not have to use your real name when generating your key, but you should enter the email address of the account with which you intend to use Mailvelope. If you like, you can create a new email account specifically for this purpose.
- We recommend that you generate a unique key pair for each email account you want to use with Mailvelope.

**Step 4**. **Uncheck** the *Upload public key to Mailvelope Key Server* box

**Step 5**. **Click** **[Submit]** to begin generating your key pair:

![](mailvelope-all-en-v01-005.png)

When it is finished, Mailvelope will display: "**Success! New key generated and imported into key ring**".

**Step 6**. **Click** *Display keys* to have a look at your new key pair, as shown in the section below



## 2.2 Export and Send Your Public Key with Mailvelope

You must share your public key with others in order for them to send you encrypted email. You should also share the full *fingerprint* of your key, through a different channel, so that your correspondents can verify that the public key you sent them really belong to you. **You should never share your private key**, as anyone who has a copy of it can decrypt messages sent to you and sign messages so they appear to have come from you.

To export your public key with Mailvelope, follow the steps below.

**Step 1**. From the **Mailvelope Options** browser tab, **select** the **Key Management** tab then **click** **[Display Keys]**, on the left.

![](mailvelope-all-en-v01-006.png)

**Step 2**. **Click** the key you want to export. (In our case, the public key we just generated is the only one we have.) 

This will activate the screen below:

![](mailvelope-all-en-v01-007.png)

This screen displays, among other things, the fingerprint of your key pair. For example, the fingerprint of the key pair we just generated for *ekaterina@riseup.net* is **3B9F 54DD 571A 6F77 251D 92E7 E8B1 F5E6 FBB4 EFFE**.

**Step 3**. **Click** the **Export** tab.

![](mailvelope-all-en-v01-008.png)

**Important:** Make sure that **[Public]** is selected at the top of the screen. If either *[Private]* or *[Any]* is selected, you will end up exporting your private key. You should never send your private key to another person or upload it to a server. (The only reasons you might want to export your private key are to make an encrypted backup or to migrate your keys to a new web browser.) The default filename should end with "_Pub.asc".

**Step 5**. **Click** **[Save]** to save your public key

**Step 6**: Send the file you just exported (*Elena_Katerina_Pub.asc*, in this case) to correspondents with whom you want to exchange encrypted email.



## 2.3 Import a public key with Mailvelope

Before you can encrypt a message to a correspondent, you need to import his public key. To import a correspondent's public key using Mailvelope, follow the steps below. 

**Step 1**. After receiving a public key as an attachment, save the file somewhere on your computer.

**Step 2**. From the **Mailvelope Options** browser tab, **select** the **Key Management** tab then **click** **[Import Keys]** on the left.

![](mailvelope-all-en-v01-009.png)

On this screen, you can: 

- Search a public key server by entering your correspondent's name, email address or key ID
- Select a text file containing a key 
- Copy and paste the text block inside a key file

The steps below assume that you received a key file and saved it to your computer, so we will use the second option.

**Step 3**. **Click** **[Select a key text file to import]**. 

**Step 4**. **Navigate** to the key file on your computer and **click** **[Import]**

When it is finished, Mailvelope will display something like: "**Success! Public key 6764717C5D64FBB6 of user Mansour <mansour@riseup.net> imported into keyring**" 

If you click **[Display keys]**, on the left, from the **Key Management** tab, you should see your newly imported public key: 

![](mailvelope-all-en-v01-010.png)

Before sending an encrypted message to this correspondent, you should verify his key.



## 2.4 Verify a correspondent's public key

You should now verify that the key you have imported actually came from the person to whom you think it belongs. You and your email correspondents should go through this process for each public key you receive.

To verify your correspondent's public key, contact him using a means of communication that allows you to be absolutely certain that you are talking to the right person. In-person meetings are best, but voice and video conversations are acceptable if you are confident you can recognise voice or appearance. You will be exchanging public key fingerprints, which do not need to be kept secret, so this conversation does not have to be confidential as long as you refrain from discussing sensitive topics.

Both you and your correspondent should verify the fingerprints of the public keys you have exchanged. A fingerprint is a unique series of numbers and letters that identifies a key. You can use the **Display Keys** section of the **[Key Management]** tab in **Mailvelope Options** to determine:

- The fingerprint of the key pair you have generated
- The fingerprint of other people's public keys that you have imported

To view the fingerprint of a particular key pair, follow the steps below:

**Step 1**. **Click** **[Display keys]**, on the left, from the **Key Management** tab. 

![](mailvelope-all-en-v01-010.png)

**Step 2**. **Click** the key you want to verify

![](mailvelope-all-en-v01-035.png)

In the Key Details window, you will see the **fingerprint** of the selected key. For example, the fingerprint of ekaterina@riseup.net is *3B9F 54DD 571A 6F77 251D 92E7 E8B1 F5E6 FBB4 EFFE*.

Your correspondent should carry out these steps as well. To verify fingerprints:

- Read the fingerprint of your key pair to your correspondent,
- Have him verify that the fingerprint he has for your public key matches what you just told him,
- Have your correspondent read you the fingerprint for his public key,
- Verify that the fingerprint you have for his public key matches what he just told you,
- If the fingerprints don't match, exchange public keys again and repeat the process.

Note: Because key fingerprints are not themselves sensitive, you can easily write down the fingerprint that your correspondent reads off to you. Then, when you have more time, you can verify that it matches the fingerprint you have for his public key. This is also why some people print their key pair fingerprints on their business cards.


## 2.5 Backup and recover all of your keys

The key pair(s) you have generated and the public keys you have collected and verified are the most important element of your Mailvelope installation. You can save all of these keys in a single file in order to back them up. See [Recover from information loss](../../backup) to plan a secure backup strategy. We recommend updating this backup any time you generate a new key pair or import and verify an important public key. 

**Important:** Because this file will contain your private key, you should not upload it to a server or to any sort of "cloud storage."


**To save all of your keys in a single file**, follow the steps below from the Mailvelope **Key Management** tab

**Step 1**. **Click** **[Display Keys]**

![](mailvelope-all-en-v01-011.png)

**Step 2**. **Click** **[Export]**

![](mailvelope-all-en-v01-012.png)

**Note:** You can choose any name and location for the file that will contain your keys. In this example, we will use the default name: **all_keys.asc**

**Step 3**. **Click** **[Save]**

**Step 4**. Make a secure backup of this file, then remove it from your computer.

**Important:** This file contains your private key(s), so you should keep your backup safe. For example, you might want to store it in an encrypted VeraCrypt container on well hidden USB storage device.

**To import all of the keys in this file**, follow the steps to *Import a Correspondent's Public Key* in Section 2.3. 


# 3. Configure Mailvelope to work with your webmail service

Mailvelope comes preconfigured to work with several webmail services, including Gmail. You can check if Mailvelope is already configured to work with your webmail provider by loging into your email account and composing new message. You should see a Mailvelope button in the upper, right-hand corner of the message area, as shown below: 

![](mailvelope-all-en-v01-016.png)

If you see this button, you can skip the remaining steps in this section.

To make Mailvelope work with the *Roundcube* webmail interface used by [Riseup](https://mail.riseup.net) and other providers, follow the steps below. By following a similar process, you should be able to configure Mailvelope for other webmail providers, as well.


**Step 1**. **Launch** the browser on which you installed Mailvelope 

**Step 2**. **Sign in** to your email account

**Step 3**. **Navigate** to your inbox and **open** any e-mail message

**Step 4**. **Click** the Mailvelope lock icon in your browser toolbar to open the Mailvelope menu as shown below

![](mailvelope-all-en-v01-013.png)

**Step 5**.  **Click** **[Add]** to display a screen containing a **List of E-Mail Providers**

![](mailvelope-all-en-v01-014.png)

At the bottom of this list, you should see a new entry for **mail.riseup.net**.

**Step 6**. Switch back to the browser tab with your webmail. 

**Step 7**. **Click compose** to write a new e-mail.

**Step 8**. **Click** the Mailvelope lock icon in your browser toolbar to open the Mailvelope menu as shown below

![](mailvelope-all-en-v01-015.png)

**Step 8**. **Click** **[Add]** again. 

Your browser will once again display a screen containing a **List of E-mail Providers**. 

**Step 9**. **Close** this browser tab and return to your webmail.

**Step 10**. **Reload** the page in which you are composing a new email. 

You should see a Mailvelope button in the upper, right-hand corner of the message area, as shown below:

![](mailvelope-all-en-v01-016.png)


# 4. Encrypting and decrypting messages and files

After exchanging keys and making sure that Mailvelope is configured to work with your webmail provider, you can begin encrypting and decrypting messages. 

For an explanation of how Mailvelope works, see the [Things you should know about this tool before you start](#things-you-should-know-about-mailvelope-before-you-start) section, above. And keep in mind that Mailvelope only protects the *content* of messages and attachments. **The following information is never encrypted:**

- The *Subject:* line
- The sender's email address
- The recipients' email addresses
- Filenames of attachments
- Any real names that might be associated with senders and recipients ("**Elena S. Katerina**", for example, in the following email address: "**Elena S. Katerina <ekaterina@riseup.net>**")

So, choose your subject lines carefully and consider creating a key pair for at least one email account that does not include your real name.

Finally, when you send encrypted email, rest assured that a copy — encrypted to your public key — will be placed in your Sent mail folder.



## 4.1 Encrypting messages with Mailvelope

Using the browser on which you installed Mailvelope, log in to a webmail account with which Mailvelope has been configured to work, then begin writing a new message and follow the steps below:

**Step 1**. Fill in the **To:**, **Cc:** and **Subject:** fields, as usual:

![](mailvelope-all-en-v01-017.png)

**Note:** If you do not see the Mailvelope button in the upper, right-hand corner of the message area, please refer the *Configure mailvelope to work with your webmail provider* section, above.

**Step 2**. **Click** the Mailvelope button in the upper, right-hand corner of the message area to open Mailvelope's **Compose E-Mail** window.

![](mailvelope-all-en-v01-018.png)

**Step 3**. **Type** your  message.

**Important:** *If you intend to encrypt a message, you should type it into Mailvelope's special **Compose E-mail** window, rather than the normal text area displayed by your webmail interface.* Otherwise, your webmail provider can record unfinished drafts, as you are writing, without you knowing it. 

All email addresses in the **To:**, **Cc:** and **Bcc:** fields will be copied to the *recipients* field of Mailvelope's *Compose E-mail* window. Your message will be encrypted to all public keys associated with the addresses shown here (and to your own public key as well). You can manually add or remove address in the *Compose E-mail* window. If any of these addresses are **marked in red**, it indicates that you do not have a public key for that recipient, and you will not be able to send the message unless you remove that recipient or obtain her public key.

**Note:** Because of the way OpenPGP works, you should not rely on the **Bcc** field to hide the existence of some recipients from other recipients.

**Step 3**. When you are done selecting recipients and composing your message, **click [Encrypt]**. Your message will be encrypted and transferred to your webmail's normal message area.

![](mailvelope-all-en-v01-019.png)

**Step 4**. **Click [Send]**.


## 4.2 Decrypting messages with Mailvelope 

Using the browser on which you installed Mailvelope, log in to a webmail account with which Mailvelope has been configured to work, open an encrypted message that has been sent to you and follow the steps below:

Mailvelope will automatically detects if an incoming message is encrypted. It will display the Mailvelope icon over the encrypted message, as shown below

![](mailvelope-all-en-v01-020.png)

**Step 1**. **Click** the Mailvelope icon to activate the password screen.

**Step 2**. **Type** the passphrase you chose when you generated your key pair

![](mailvelope-all-en-v01-021.png)

**Important:**  If you check the *Remember password temporarily* box, Mailvelope will remember your passphrase for 30 minutes. (You can change this length of time in Mailvelope's Options.) We recommend unchecking this box unless you are about to decrypt many messages.

**Step 3**. **Click** **[OK]** to decrypt the message

![](mailvelope-all-en-v01-022.png)

**Note:** If Mailvelope displays a message saying, *Error! No private key found for this message*, it means the sender did not encrypt this message to your public key (and may not even *have* your public key). You will not be able to decrypt the message. Contact the sender and ask her to re-send the message encrypted to your key. You might also want to send her your key and offer to verify your fingerprint.

**Important**: It is generally not a good idea to make unencrypted copies of encrypted messages or attachments and store them on your computer.

## 4.3 Signing messages and verifying signatures with Mailvelope

In addition to encrypting messages to someone else's public key, Mailvelope can *sign* them using your own private key. That way, recipients who have your public key can verify that a particular message really came from you and was not changed in transit.

Mailvelope does not currently allow you to sign and encrypt the same message.


### 4.3.1 Signing a message

To sign a message, follow the steps below.

**Step 1**. Compose a message in Mailvelope's *Compose E-Mail* window, as shown below:

![](mailvelope-all-en-v01-029.png)

**Step 2**. **Click** **[Sign]**.

![](mailvelope-all-en-v01-030.png)

**Step 3**. **Select** a private key to use when signing the message.

**Step 4**. **Click** **[OK]**.

**Step 5**. **Type** the passphrase for key you have selected.

![](mailvelope-all-en-v01-031.png)

Note that we deselected option *Remember password temporarily*.

**Step 6**. **Click** **[OK]**.

The signed message will be copied to your webmail's message area, as shown below:

![](mailvelope-all-en-v01-032.png)

**Important:** When you sign an email, it will not be encrypted. Note that you can still read the content of the message above. The block of text *below* the message is the digital signature. Do not edit the message before sending. If you do, recipients will be told that your signature is invalid.

**Step 7**. **Click** **[Send]**.



### 4.3.2 Verifying a signed message

To verify a signed message, follow the steps below while viewing the message.

![](mailvelope-all-en-v01-033.png)

**Step 1**. **Click** the envelope with the red seal that is displayed over the message.

If you have the public key for this sender, a green box should appear above the message to let you know that it was *signed* by the corresponding private key and was not changed in transit.

![](mailvelope-all-en-v01-034.png)

**Important:** If you see a red box that says *Invalid signature*, the message may have been tampered with or sent by someone else. You should contact the person in the **From:** field using some other communication channel and confirm that she sent it.

If you see a yellow box that says *Signed with an unknown key*, it means that you do not have a public key that corresponds to the private key used to sign the message. You will not be able to verify the signature until you obtain and validate the correct public key.

## 4.4 Encrypting and decrypting files with Mailvelope

Mailvelope can also encrypt and decrypt files. Encrypted files can be attached to email messages.

### 4.4.1 Encrypting and attaching files

To encrypt a file, follow steps below using the browser on which you installed Mailvelope.

**Step 1**. **Click** the Mailvelope lock icon in your browser toolbar and **select** **Options** to open the **Mailvelope Options** browser tab. 

**Step 2**. **Select** the **[File Encryption]** tab.

**Step 3**. **Click** **Encryption** on the left-hand side.

**Step 4**. **Click** **[+ Add]** to select files you would like to encrypt, as shown below.

![](mailvelope-all-en-v01-023.png)

In this example, we selected an image file called *picture.png*. You can add more than one file. Each of them will be encrypted separately to the public keys you select.

**Step 5**. **Click** **[Next]**.

![](mailvelope-all-en-v01-024.png)

**Step 6**. **Select** a corespondent for whom would like to encrypt the selected file(s).

**Step 7**. **Click** **[Add]**. 

In this example we select keys for both Elena and Mansour. **You can select more then one person, including yourself.**

**Step 8**. **Click** **[Encrypt]**.

![](mailvelope-all-en-v01-025.png)

**Step 9**. **Click** **[Save all]** to save the encrypted files.

Encrypted files will be saved to wherever your browser saves downloaded files (most likely the *Downloads* folder). The encrypted files will have a new extension, *.asc*. For example, *picture.png* will become *picture.png.asc*. You can now send the encrypted files as attachments using your webmail provider's normal attachment feature.

**Important:** Keep in mind that you still have the unencrypted version on your computer somewhere, so make sure to send the encrypted version (the one that ends in *.asc*). Also, remember that *the original filename is still visible* and will not be encrypted. So choose a name that does not reveal sensitive information.



### 4.4.2 Decrypting files

To decrypt a file, follow steps below. If the encrypted file was sent to you as an attachment, these steps assume that you have already saved it somewhere on your computer.

**Step 1**. **Click** the Mailvelope lock icon in your browser toolbar and **select** **Options** to open the **Mailvelope Options** browser tab. 

**Step 2**. **Select** the **[File Encryption]** tab 

**Step 3**. **Click** **Decryption** on the left-hand side.

**Step 4**. **Click** **[Add]** and select a file you would like to decrypt. 

![](mailvelope-all-en-v01-026.png)

You can select multiple encrypted files, as long as they were all encrypted using the same public key.

**Step 5** **Click** **[Next]**.

**Step 6**. **Type** the passphrase to your private key.

![](mailvelope-all-en-v01-027.png)

Note that we deselected option *Remember password temporarily*.

**Step 7**. **Click** **[OK]**. 

![](mailvelope-all-en-v01-028.png)

**Step 8**. **Click** **[Save all]** to save the decrypted files.

Encrypted files will be saved to wherever your browser saves downloaded files (most likely the *Downloads* folder).



# FAQ

**Q**: Can Mailvelope be installed in different browsers like Safari or Opera?

**A**: No. At this time Mailvelope only works as an add-on/extension in **Mozilla Firefox** and **Google Chrome or Chromium** browsers.

**Q**: How many accounts may I generate key pairs for?

**A**: As many as you need.

**Q**: Does Mailvelope store my private keys anywhere online (for example, in a cloud)?

**A**: No, private keys are stored on your computer. For **Firefox** it's in a profile directory, for **Chrome or Chromium** it's a user data directory. However public keys may be uploaded to Mailvelope key server.

**Q**: Does Mailvelope allow to create keys that can work for limited time only?

**A**: Not at this moment.

**Q**: Can Mailvelope be installed for a portable version of a browser?

**A**: Yes. Once you do it you can copy the browser folder which contains the Mailvelope installation and all keys to a USB and use it on another computer.