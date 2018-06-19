---
title: ""
---
# K-9 & OPEN KEYCHAIN TOOL GUIDE


**Lesson to read: [Email Advanced] (umbrella://lesson/email/1).**  
**Level**: Advanced    
**Published:** May 2018    
**Sources:** Security in a Box, [K9 WITH APG FOR ANDROID] (https://securityinabox.org/en/guide/k9/android/), Open Keychain [FAQ] (https://www.openkeychain.org/faq/). 

**K-9 Mail** is a free and open source email client for Android devices. 

**Open Keychain** is a free and open source application that lets you encrypt, decrypt and sign files, messages or emails using public key encryption like OpenPGP. It's based on code from a similar tool called APG, now unmaintained. 

**Using K-9 Mail with Open Keychain will give you:**  
- The ability to use encrypted email on your Android device.

**Download location:** [K-9 Mail](https://play.google.com/store/apps/details?id=com.fsck.k9) and [Open Keychain](https://play.google.com/store/apps/details?) in the Google Play store.  
**Software requirements:**  Android 4.0.3 and up.  
**Version used in this guide**: 5.403 (K-9 Mail); 5.0.2 (Open Keychain)  
**License**: FOSS. 

# 1. Introduction

**K-9 Mail** is a comprehensive email client that will allow you to send and receive email from one or more email accounts on your Android device, and do so more securely with [Open Keychain](https://play.google.com/store/apps/details?id=org.sufficientlysecure.keychain&hl=en_GB).

**Note:**    
- Secure messaging services like Signal are a better choice for sensitive communication than email.   
- Transferring a private encryption key onto your phone may make email on the device more secure, but also makes the key more vulnerable to loss or interception. (Open Keychain describe the risk on their [website] (https://www.openkeychain.org/faq/#are-my-secret-keys-safe-on-my-mobile-device).) 
- The *recipients* and the *subject* cannot be hidden from anyone monitoring your email, even if the email is encrypted.

Before you start using **K-9 Mail** you will need:  
- An internet connection on your phone.  
- An email account that supports either secure POP3 or IMAP connections. (See which settings you would use with the most common email providers [here] (https://k9mail.github.io/documentation/accounts/providerSettings.html).   
- An OpenPGP key-pair and public keys of the people you will communicate with. 

(Learn more about public/private key encryption in the [email] (umbrella://lesson/email) lesson. Learn how to generate your own key in the toolguides for [Mailvelope] (umbrella://lesson/mailvelope), or PGP for [LINUX] (umbrella://lesson/pgp-for-linux), [Mac OSX] (umbrella://lesson/pgp-for-mac-os-x), or [Windows] (umbrella://lesson/pgp-for-windows).)

# 2. Install and configure K9 Mail

## 2.1 Install

**Step 1.** Download and install K-9 Mail from the [Google Play](https://play.google.com/store/apps/details?id=com.fsck.k9) store. Review permissions you grant the app carefully to make sure you agree. 

![](tool_k9_1.png)

**Step 2.** **Tap** *Open* to run the app for the first time.

## 2.2 Configure

Click *Next* to begin the account setup. 

Where possible, **K-9 Mail** will attempt to configure your account automatically.  If this is not possible, or if you wish to have more control over the account setup process, you can also configure it manually.

**Step 1:** Enter your email address and password in the fields provided and tap *Next.* 

![](tool_k9_2.png)

K-9 Mail will connect to the internet and attempt to get your account settings.
 
**Note**: Users with two factor authentication enabled on their email account may need to take an extra step to use K-9 Mail. 
 
For example:      
* Gmail users must allow less secure apps to access their accounts under settings, and generate a one-time password. Read more [here] (https://support.google.com/accounts/answer/6010255?hl=en).   
* Yahoo users can allow apps that use less secure signin under Account Settings. Read more [here] (https://help.yahoo.com/kb/SLN27791.html?guccounter=1). 
 
(The providers classify K-9 Mail as "less secure" because it doesn't use the same authentication protocol. But trusted open source tools like K-9 Mail are still considered secure for encrypted email.)


**Step 2**: Enter your name as you want it to be displayed on all outgoing email give the account a name to distinguish between multiple accounts.  Tap *Done*.

**Step 3:** Send yourself an email from your computer to make sure you can read it in K-9 Mail. 

**Note:** If you choose *manual setup,* you will be asked to select the settings for your email type (IMAP/POP/Exchange), and the incoming and outgoing server settings. Refer to your email client settings on your computer for this information.   

- For server settings, always ensure that the *security type* is set to either *STARTTLS* or *SSL/TLS*. **Never** use the *none* option. 
 
- If K-9 Mail displays a warning about the certificate of your secured connection, *don't ignore it,* but verify that the certificate really belongs to your mail server. If it does not, your communications could be intercepted. You should see a SHA-1 fingerprint at the very end of the warning. Check on your computer if the installed certificate from your mail server has the same fingerprint, or find a way to check your mail server's certificate directly from your provider. 


We recommend that you use **K-9 Mail** in addition to your computer's email client. When you download email, it will not delete the email from the server by default, since you want to receive the email on your computer, too. But this, and other settings, can be changed. Long press on the account you have just set up and select *account settings* from the menu, or tap the three dots in the bottom right corner of the app and select Settings to review your options.


# 3. Send and receive encrypted email 

**Step 1:** Under Settings, tap *Cryptography*. If you haven't already, K-9 Mail will prompt you to download Open Keychain. Once you have Open Keychain downloaded, select it in K-9 Mail.

![](tool_k9_5.png)
  
Before you can start sending and receiving encrypted email, you need to ensure that you have all your OpenPGP keys imported into Open Keychain.  

# 4. Set up Open Keychain

Tap Open Keychain to open the app. Under Settings, tap *Manage my keys*. 

![](tool_k9_6.png)  

**Option 1:** If you are using PGP for the first time or wish to create a new key, tap *Create my key* and follow the instructions.

**Option 2:** If you already have a PGP key and wish to use it on your Android device, open the program you use to manage keys on your computer (such as GPG Keychain or Mailvelope) and export your own key, including your private or secret key. Save the file in a secure location. 

**Note:** Your private key can be used to impersonate you and decrypt your encrypted communications. Transferring it to a mobile device is risky because the file could be lost or intercepted. 

If you choose to transfer your private key file, take precautions:    

- Connect your trusted Android device to your trusted computer using a USB cable to transfer it directly, or enable Bluetooth on your trusted computer and your trusted Android device (check the pairing codes match) and use the "send file to device" function; or, 
- See [Open Keychain's] (https://www.openkeychain.org/faq/#what-is-the-best-way-to-transfer-my-own-key-to-openkeychain) advice for password-protecting your key using the command line before transferring it over the internet.

In Open Keychain's *Manage my keys* window, tap *Import key from file* and then the file icon. Navigate to the folder where you moved the file, select it, and tap *OPEN*. You can also use the *Import key from file* to transfer public keys that other people have shared with you. Successfully imported keys will now appear in your list of keys. Once you see them in Open Keychain, delete the files from your device. Don't leave them sitting in a folder.     

(To learn more about managing keys, read the Keyring and Key-signing party entries in the Umbrella glossary.)


# 5. Exchange encrypted email with K9

**Step 1:** From any screen in **K-9 Mail** tap the envelope+ icon to start a new email to someone you have already exchanged public keys with. 

**Step 2:** Add the recipient's email address in the *To* field.

**Step 3:**   

![](tool_k9_7.png)

Tap the grey lock icon; it will turn green when encryption is active.  

![](tool_k9_8.png) 

**Step 4:** Send the message.

**Step 5:** When you receive an encrypted reply, K-9 Mail will automatically prompt you to enter your GPG passphrase and decrypt the mail.