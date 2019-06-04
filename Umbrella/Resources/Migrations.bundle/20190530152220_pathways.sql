ALTER TABLE "checklist" ADD COLUMN name TEXT NOT NULL DEFAULT "";

---------------------
------ English ------
---------------------
INSERT INTO "category" ('id', 'name', 'index', 'folder_name', 'deeplink', 'parent', 'language_id', 'description', 'icon', 'template') VALUES (721,'Pathways', -1.0, '', 'pathways', 0, 2,'','','');
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (380, 1.0, 'Security Planning', 721);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (381, 2.0, 'Digital Basics', 721);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (382, 3.0, 'Physical Basics', 721);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (383, 4.0, 'Digital Crisis', 721);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (384, 5.0, 'Physical Crisis', 721);

-- Digital Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Secure your [iPhone](umbrella://tools/encryption/s_encrypt-your-iphone.md) or [Android](umbrella://tools/other/s_android.md)',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Learn about [HTTPS](umbrella://communications/email/beginner) and using it everywhere',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Use [strong passwords](umbrella://information/passwords/beginner), [KeePassXC](umbrella://tools/encryption/s_keepassxc.md), and [2FA](umbrella://information/passwords/advanced)',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Use Signal for [messaging](umbrella://communications/sending-a-message/beginner) and [calls](umbrella://communications/making-a-call/beginner) ([Android](umbrella://tools/messaging/s_signal-for-android.md) and [iOS](umbrella://tools/messaging/s_signal-for-ios.md))',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Delete](umbrella://information/safely-deleting/beginner), [back up](umbrella://information/backing-up/advanced), [restore](umbrella://information/backing-up/advanced/s_accidental-file-deletion.md), or [encrypt](umbrella://information/protecting-files/beginner) files',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Choose [open source](umbrella://information/malware/beginner) software and [secure settings](umbrella://information/protect-your-workspace/expert/s_software-and-settings.md)',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Defend yourself from [malware](umbrella://information/malware/advanced), [phishing](umbrella://communications/phishing/beginner), and [social engineering](umbrella://communications/phishing/beginner/s_social-engineering.md)',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Make an informed choice about [email](umbrella://communications/email/advanced) encryption',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Privacy on [social media, blogs, and the cloud](umbrella://communications/online-privacy/beginner)',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Protect your [metadata](umbrella://communications/online-privacy/advanced/s_anonymity-online.md) with tools like [ObscuraCam](umbrella://tools/messaging/s_obscuracam.md)',0,381);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Use a [VPN](umbrella://communications/censorship/beginner/s_virtual-private-networks.md) to disguise your location or [Tor](umbrella://communications/online-privacy/advanced/s_tor.md) to protect your anonymity ([Windows](umbrella://tools/tor/s_tor-for-windows.md), [Mac](umbrella://tools/tor/s_tor-for-mac-os-x.md), [Linux](umbrella://tools/tor/s_tor-for-linux.md))',0,381);

-- Digital Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('You found [malware](umbrella://information/malware) on your computer',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Your email has been [hacked](umbrella://communications/email)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Internet [censorship](umbrella://communications/censorship)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Dealing with [hate speech](umbrella://communications/online-abuse/advanced/s_hate-speech.md) on social media',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Respond to blackmail, doxxing, identity theft, or other [online abuse](umbrella://communications/online-abuse)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Receiving a [phishing](umbrella://communications/phishing/beginner) message',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Emergency Support](umbrella://emergency-support/digital)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Report or record [digital security incidents](umbrella://forms/f_digital-security-incident.yml)',0, 383);


-- Physical Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Signs of [stress](umbrella://stress/stress)',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Home and office](umbrella://information/protect-your-workspace) security',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Pros and cons of [radio and satphone](umbrella://communications/radios-and-satellite-phones) communication',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Medical](umbrella://travel/preparation/beginner/s_medical.md) precautions for travel',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Simple [precautions](umbrella://travel/borders/beginner) in hostile environments',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Always [wear a seatbelt](umbrella://travel/vehicles/beginner/s_wear-a-seatbelt.md)',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Prepare a [cover story](umbrella://travel/checkpoints/beginner)',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Establish [codes](umbrella://communications/mobile-phones/beginner/s_information-sent.md),  [duress words](umbrella://communications/radios-and-satellite-phones/beginner/s_radio-procedures.md),  and [proof of life](umbrella://forms/f_proof-life-form.yml) for your team
',0, 382);
INSERT INTO "check_item"  ('name', 'is_label', 'checklist_id')VALUES ('Manage [relationships](umbrella://work/public-communications) with authorities, the media, and the public',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Pack for a [trip](umbrella://travel/preparation/beginner),  [vehicle](umbrella://travel/vehicles/beginner/s_drivers-and-vehicles.md),  [safe house](umbrella://incident-response/evacuation/beginner/s_safe-houses.md),  or emergency [grab bag](umbrella://travel/protective-equipment/beginner)
',0, 382);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Equipment](umbrella://travel/protective-equipment/advanced) for extreme or combat conditions',0, 382);


-- Physical Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Approaching a [border](umbrella://travel/borders/beginner)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Approaching a [checkpoint](umbrella://travel/checkpoints/beginner/s_on-approach.md)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Vehicle [accidents](umbrella://travel/vehicles/beginner/s_accidents.md)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('If you are [kidnapped](umbrella://incident-response/kidnapping/advanced/s_if-you-are-kidnapped.md), [arrested](umbrella://incident-response/arrests/beginner/s_if-you-are-arrested.md), or [sexually assaulted](umbrella://incident-response/sexual-assault/advanced)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('If a team member is [kidnapped](umbrella://incident-response/kidnapping/expert), [arrested](umbrella://incident-response/arrests/advanced), or [sexually assaulted](umbrella://incident-response/sexual-assault/expert)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Being [followed](umbrella://work/being-followed)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('When to [evacuate](umbrella://incident-response/evacuation/advanced)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[PTSD](umbrella://stress/stress/expert)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Emergency Support](umbrella://emergency-support/physical/beginner)',0, 384);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Report or record [physical security incidents](umbrella://forms/f_physical-security-incident.yml)',0, 384);

-- Security Planning

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Identify [threats](umbrella://assess-your-risk/security-planning/beginner) based on where you are and what you do',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Identify [threats to information](umbrella://information/managing-information/beginner) and how to protect it',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Make a plan to [protect your workspace](umbrella://information/protect-your-workspace/beginner)',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Make a [travel security](umbrella://travel/preparation/beginner) plan',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Assess your risk before crossing [borders](umbrella://travel/borders/beginner)',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Prepare for safer [vehicle](umbrella://travel/vehicles/beginner) travel',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Reduce your risk of [kidnap](umbrella://incident-response/kidnapping/beginner), [arrest](umbrella://incident-response/arrests/beginner), and [sexual assault](umbrella://incident-response/sexual-assault/beginner)',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Prepare to [cover](umbrella://work/protests/beginner) or [participate](umbrella://work/protests/advanced) in protests',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id')  VALUES ('Create an [evacuation](umbrella://incident-response/evacuation/beginner) plan',0, 380);
