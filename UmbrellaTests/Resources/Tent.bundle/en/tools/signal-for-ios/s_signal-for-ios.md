---
title: ""
---
Signal for iOS
=========================

Secure Messages 

**Lesson to read: [Sending a message] (umbrella://lesson/sending-a-message)**  
**Level**: Beginner-Intermediate  
**Time required**: 15-20 minutes  
**Published:** April 2018  (some images date from earlier versions)  
**Sources:** EFF, Surveillance Self-Defense [How to: Use Signal on iOS] (https://ssd.eff.org/en/module/how-use-signal-ios); Security in a Box [SIGNAL FOR ANDROID] (https://securityinabox.org/en/guide/signal/android/).

**Using Signal will give you:**

- The ability to send end-to-end encrypted group, text, picture, and video messages, and have encrypted phone conversations with other Signal users. 

**Download location**: The [Apple App Store](https://itunes.apple.com/us/app/signal-private-messenger/id874139669?mt=8)

**System requirements**: iOS 8.0 or later. Compatible with iPhone, iPad, and iPod touch.
(you need to have an Apple account which will be linked to the installation of the app).

**Version used in this guide**: Signal iOS 2.8.1

**License:** GPLv3

**Other reading**:

*   [http://support.whispersystems.org/](http://support.whispersystems.org/)
*   [https://signal.org/blog/standalone-signal-desktop/](https://signal.org/blog/standalone-signal-desktop/)
*   [https://whispersystems.org/blog/signal-video-calls/](https://whispersystems.org/blog/signal-video-calls/)


Introduction 
-----------------
Signal is a free and open source software application for Android, iOS, and Desktop that employs end-to-end encryption, allowing users to send end-to-end encrypted group, text, picture, and video messages, and have encrypted phone conversations between Signal users.  

Although Signal uses telephone numbers as contacts, encrypted calls and messages actually use your data connection; therefore both parties to the conversation must have Internet access on their mobile devices. Due to this, Signal users don’t incur SMS and MMS fees for these type of conversations. 

On Android, Signal can replace your default text messaging application, so within Signal it is still possible to send unencrypted SMS messages.

Note:  
* Signal prevents others from accessing the content of your messages and voice calls, but it does not hide the fact that you are sending encrypted messages or making encrypted voice calls. In some countries, encryption tools like Signal might attract attention or violate legal constraints.  
* Open Whisper Systems, the makers of Signal, use other companies' infrastructure (Apple on iOS) to send its users alerts when they receive a new message. That means some metadata, or information about who is receiving messages and when they were received, may leak to these companies.




Installing Signal – Private Messenger on your iPhone 
----------------------------------------------------------------------

### Step 1: Download and Install Signal – Private Messenger

On your iOS device, enter the App Store and search for “Signal.” Select  [Signal – Private Messenger](https://itunes.apple.com/us/app/signal-private-messenger/id874139669?mt=8) by Open Whisper Systems.

Tap "GET" to download the app, then "INSTALL." You may be prompted to enter your Apple ID credentials. Once it has downloaded, click “OPEN” to launch the app.

### Step 2: Register and Verify your Phone Number

You will now see the following screen. Enter your mobile phone number and tap “Verify This Device.”

![](tool_signalios_resized000.png)

![](tool_signalios_resized001.png)

In order to verify your phone number, you will be sent an SMS text with a six-digit code. You will now be prompted to enter that code, and then tap "Submit Verification Code."

![](tool_signalios_resized002.png)

After this process is complete, Signal will request access to your contacts. Tap "Continue."

![](tool_signalios_resized003.png)

Signal will then request permission to send you notifications. Tap "OK."

![](/tool_signalios_resized004.png)

 

Using Signal 
------------------------------

In order to use Signal, the person that you are calling must have Signal installed. If you try to call or send a message to someone using the Signal app and they do not have any of the aforementioned apps installed, the app will ask if you would like to invite them via SMS, but it will not allow you to complete your call or send a message to them from inside the app.

Signal provides you with a list of other Signal users in your contacts. To do this, data representing the phone numbers in your contact list is uploaded to the Signal servers, although this data is deleted almost immediately.

 

How to Send an Encrypted Message 
--------------------------------------------------

Note that Open Whisper Systems, the makers of Signal, use other companies' infrastructure to send its users alerts when they receive a new message. It uses Google on Android, and Apple on iPhone. That means information about who is receiving messages and when they were received may leak to these companies.

To get started, tap the compose icon in the upper-right corner of the screen.

![](tool_signalios_resized005-compose.png)

You will see a list of all the registered Signal users in your contacts.

![](tool_signalios_resized008.png)

When you tap a contact, you'll be brought to the text-messaging screen for your contact. From this screen, you can send end-to-end encrypted text, picture, or video messages.

![](tool_signalios_resized010.png)

### How to Initiate an Encrypted Call

To initiate an encrypted call to a contact, select that contact and then tap on the phone icon.

![](tool_signalios_resized010-phone.png)

At this point, Signal may ask for permission to access the microphone. Tap "OK."

![](tool_signalios_resized011.png)

Once a call is established, your call is encrypted.

### How to Initiate an Encrypted Video Call

To make an encrypted video call, simply call someone as described above:

![](tool_signalandroid_initial_video_screen.png)

and tap the video camera icon. You may have to allow Signal to access video from your camera. This shares your video with your friend (your friend may have to do the same).


### How to Start an Encrypted Group Chat

You can send an encrypted group message by tapping the compose icon in the upper-right corner of the screen (the square with a pencil pointing to the center), and then tapping the icon in the same place with three figures.

![](tool_signalios_resized005-compose.png)

![](tool_signalios_resized008-group.png)

On the following screen, you'll be able to name the group and add participants to it. After adding participants, you can tap on the "+" icon in the upper right corner of the screen.

![](tool_signalios_resized023-plus.png)

This will initiate the group chat.

![](tool_signalios_resized024.png)

If you wish to change the group name, or add or remove participants, this can be done from the group chat screen by tapping the overflow icon (the three dots in the upper-right corner of the screen) and selecting “Edit group.”

### How to Verify your Contacts

At this point, you can verify the authenticity of the person you are talking with, to ensure that their encryption key wasn't tampered with or replaced with the key of someone else when your application downloaded it (a process called key verification). Verifying is a process that takes place when you are physically in the presence of the person you are talking with.

First, open the screen where you are able to message your contact, as described above. From this screen, tap the name of your contact at the top of the screen.

![](tool_signalios_resized010-name.png)

From the following screen, tap "Verify Safety Numbers."

![](tool_signalios_resized015-verify.png)

You will now be brought to a screen which displays a QR code and a list of 'safety numbers.' This code will be unique for every different contact you are conversing with. Have your contact navigate to the corresponding screen for their conversation with you, so that they have a QR code displayed on their screen as well.

![](tool_signalios_resized016.png)

Back on your device, tap "Scan Code." At this point, Signal may ask for permission to access the camera. Tap "OK."

![](tool_signalios_resized017.png)

Now you will be able to use the camera to scan the QR code that is displayed on your contact's screen. Align your camera to the QR code:

![](tool_signalios_resized018.png)

Hopefully, your camera will scan the barcode and show a "Safety Numbers Verified!" dialogue, like this:

![](tool_signalios_resized019.png)

This indicates that you have verified your contact successfully. If instead your screen looks like this, something has gone wrong:

![](tool_signalios_resized020.png)

You may want to avoid discussing sensitive topics until you have verified keys with that person.

_Note for power users: The screen displaying your QR code also has an icon to share your safety number_ _in the top-right corner. In-person verification is the preferred method, but you may have already authenticated your contact using another secure application, such as PGP. Since you've already verified your contact, you can safely use the trust established in that application to verify_ _numbers within Signal, without having to be physically in the presence of your contact. In this case you can share your safety number with that application by tapping the "share" icon, and send your contact your safety number._

### Disappearing Messages

Signal has a feature called disappearing messages which ensures that messages will be removed from your device and the device of your contact some chosen amount of time after they are seen. To enable disappearing messages for a conversation, open the screen where you are able to message your contact. From this screen, tap the name of the contact at the top of the screen, then tap the slider next to "Disappearing Messages."

![](tool_signalios_resized015-slider.png)

A slider will appear that allows you to choose how quickly messages will disappear:

![](tool_signalios_resized021.png)

After you select an option, you can tap the "<" icon on the top-left corner of the screen, and you should see information in the conversation indicating that “disappearing messages” have been enabled.

![](tool_signalios_resized022.png)

You can now send messages with the assurance that they will be removed after the chosen amount of time.