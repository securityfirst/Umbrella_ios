---
title: ""
---
Orbot & Orfox
---

Privacy-Enhanced Web Browsing for Android

**Lesson to read: [Internet](umbrella://lesson/the-internet), [Mobile Phones] (umbrella://lesson/mobile-phones)**  
**Level**: Beginner  
**Time required**: 15 minutes  
**Published:** April 2018    
**Sources:** Security Planner (Citizen Lab), [Orbot and Orfox] (https://securityplanner.org/#/tool/orbot-and-orfox); Security in a Box, [ORBOT FOR ANDROID](https://securityinabox.org/en/guide/orbot/android/), The Guardian Project, [Orbot v16: a whole new look, and easier to use!] (https://guardianproject.info/2018/01/05/orbot-v16-a-whole-new-look-and-easier-to-use/)

**Using Orbot and Orfox together will give you:**  
- The ability to conceal your online identity from websites and other services when using certain Android applications.  
- The ability to conceal your browsing activities when using Orfox.  
- The ability to bypass Internet censorship and online filtering when using Orfox.

**Download location:** [Orbot] (https://play.google.com/store/apps/details?id=org.torproject.android) and [Orfox] (https://play.google.com/store/apps/details?id=info.guardianproject.orfox) in the Google Play store.  
**Software requirements:**  Varies with device (Orbot); Android 4.0.3 and up (Orfox)   
**Version used in this guide**: Version 16 (Orbot) Fennec-52.7.3esr/TorBrowser-7.5.3/Orfox-1.5.2-RC-1 (Orfox)   
**License**: FOSS (primarily GPLv2)


# 1. Introduction 

Orbot allows other apps on Android devices to use the Internet more securely via the Tor Network. (Learn more about [**Tor**](umbrella://lesson/internet/1).) Orfox is a version of the Tor browser for Android that uses Orbot to connect to the Tor Network. 

Remember, if you use Orfox to return to content you have already created without using Orfox, like a blog post, the site hosting the content will still know your real location.

If you want stronger anonymity while using Orfox:

*   Never access accounts made in your real name.
*   Never give your personal data.
*   Avoid doing things that you do when not trying to be anonymous.


# 2. Install and configure Orbot


## 2.1 Install Orbot

**Step 1:** On your Android device, **download** and **install** the app from the [Google Play store](https://play.google.com/store/apps/details?id=org.torproject.android) store by pressing INSTALL. 

![](orbot-and-002.png)

**Note:** **Orbot** can also be downloaded from the third party [F-Droid](https://guardianproject.info/fdroid/) store.


## 2.2 Configure Orbot

**Step 1:** Click **Open.**

![](orbot-and-005.png)

**Step 2:** **Swipe** through the welcome screens in the setup wizard, or touch the Next arrow. 

![](orbot-and-006.png) ![](orbot-and-007.png)

**Step 3:** If your access to the Tor network may be blocked, you may need to use a bridge.

![](orbot-and-009.png)  

![](orbot-and-010.png)

If you're not sure whether you need a bridge, try it without first. To learn more about bridges, read *Advanced Orbot configuration: Use a Tor bridge* below.

**Step 4:** If you want to access an app that is blocked, use Orbot as a VPN (virtual private network) by  clicking on **Choose Apps**.

![](orbot-and-008.png)

Select individual apps you want to use with **Orbot** and click *OK*.  

> "Rather than promote some kind of auto-magical “enable Tor for my whole device”, we want to focus on ways to enable specific apps to go through Tor, in a way we can ensure is as safe as possible." —The Guardian Project, [October 27, 2017] (https://guardianproject.info/2017/10/27/no-more-root-features-in-orbot-use-orfox-vpn-instead/)
 
Note that many apps, such as those that require you to log in, will undermine your anonymity even if Internet traffic is tunneled through Orbot. This step will help you if a firewall or a filter is blocking an individual app, but does not make you anonymous.    


![](orbot-and-011.png)

![](orbot-and-012.png)

When you are done with configuration, you will be presented with the deactivated **Orbot** screen.

![](orbot-and-013.png)

# 3. Start using Orbot

**Step 1:** Touch the grey Orbot icon in the centre of the screen until it turns yellow.

![](orbot-and-014.png) 

**Step 2:** When it connects, Orbot turns green. 
 
![](orbot-and-015.png) 

**Step 3:** Touch the green icon until it turns grey to disconnect, or click on the menu icon in the top right of the screen and select Exit to quit the app.

![](orbot-and-019.png)

**Step 4:** Touch *Global (Auto)* to select from a list of locations your Internet traffic can appear to be from. 

![](orbot-and-022.png)

**Step 5.** Toggle VPN mode *On* to access listed apps by tunnelling their Internet traffic through Orbot. Add more apps to the list by clicking on *Tor-enabled Apps* at the bottom of the screen.  


# 4. Advanced Orbot configuration: Use a Tor Bridge

If Tor access is restricted or you wish to disguise the fact that you are using Tor, you can configure Orbot to use *bridges*. Learn more about bridges in the [Tor for LINUX](umbrella://lesson/tor-for-linux) tool guide. 

**Step 1:** Tap the menu icon in the top right, and select *Settings*. Scroll down to *Bridges.* Check the box beside *Use Bridges.* 
 
![](orbot-and-025.png)

**Step 2:** If you know the *IP address* of a *bridge* you want to use, tap *IP address and port of bridges*. Enter the IP address and tap *OK*.

![](/media/orbot-and-026.png)
 
**Step 3:** Restart **Orbot** to begin using the *bridge*.

You can read more about bridges on the [Tor project website](https://bridges.torproject.org/).


# 5. Install Orfox

**Step 1:** On your Android device, **download** and **install** the app from the [Google Play store](https://play.google.com/store/apps/details?id=info.guardianproject.orfox).

**Note:** **Orfox** can also be downloaded from the third party [F-Droid](https://guardianproject.info/fdroid/) store.

**Step 2:** To open Orfox, **tap** the application's icon.

**Orfox** will give you the option to connect to _https://check.torproject.org_, to ensure that its connection to the **Tor** network is working. If it can connect, you will see a message telling you that your _browser is configured to use Tor_. If **Orfox** can not connect to the website you will see an error message in the browser. If this happens, check that Orbot is running.

**Step 3:** To browse to websites, **tap** the area at the top of the screen and type in the address you want to visit. Press *Go* on the onscreen keypad.


# 6. Clear your Orfox browser history

**Step 1:** To manually clear your browsing history and cache, and hide the websites you have visited in Orfox, tap on the main menu icon with three dots in the top right corner, then *Settings*.

**Step 2:** Tap on *Clear private data,* then *CLEAR DATA,* to delete data from the categories listed. 

Note: When you set this, you will not be able to press the back button to view web pages you have already visited.

**Step 3:** Return to the *Settings* menu and select *Privacy.* Select _Clear private data on exit_ to automatically clear private data when you quit the app via the main menu.

Note: Selecting *New private tab* from the main menu will also prevent Orfox from recording any browsing history. Files you download and web pages you bookmark will still be saved on your device. 

# 7. Customise your broswer security

Orfox includes a security slider feature that allows you to choose between Standard, Safer, and Safest security settings. Tap on the main menu icon with three dots in the top right corner, then *Orfox Settings*. Safer and Safest settings will cause some website features to break, but you will be less exposed to vulnerabilities that hackers can exploit to attack you.