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


-- Security Planning

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Identify [threats](umbrella://assess-your-risk/security-planning/beginner) based on where you are and what you do',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Identify [threats to information](umbrella://information/managing-information/beginner) and how to protect it',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Make a plan to [protect your workspace](umbrella://information/protect-your-workspace/beginner)',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Make a [travel security](umbrella://travel/preparation/beginner) plan',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Assess your risk before crossing [borders](umbrella://travel/borders/beginner)',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Prepare for safer [vehicle](umbrella://travel/vehicles/beginner) travel',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Reduce your risk of [kidnap](umbrella://incident-response/kidnapping/beginner), [arrest](umbrella://incident-response/arrests/beginner), and [sexual assault](umbrella://incident-response/sexual-assault/beginner)',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Prepare to [cover](umbrella://work/protests/beginner) or [participate](umbrella://work/protests/advanced) in protests',0, 380);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Create an [evacuation](umbrella://incident-response/evacuation/beginner) plan',0, 380);


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


-- Digital Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('You found [malware](umbrella://information/malware) on your computer',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Your email has been [hacked](umbrella://communications/email)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Internet [censorship](umbrella://communications/censorship)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Dealing with [hate speech](umbrella://communications/online-abuse/advanced/s_hate-speech.md) on social media',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Respond to blackmail, doxxing, identity theft, or other [online abuse](umbrella://communications/online-abuse)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Receiving a [phishing](umbrella://communications/phishing/beginner) message',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Emergency Support](umbrella://emergency-support/digital)',0, 383);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Report or record [digital security incidents](umbrella://forms/f_digital-security-incident.yml)',0, 383);


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


---------------------
------ Spanish ------
---------------------

INSERT INTO "category" ('id', 'name', 'index', 'folder_name', 'deeplink', 'parent', 'language_id', 'description', 'icon', 'template') VALUES (722,'Pathways', -1.0, '', 'pathways', 0, 3,'','','');
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (385, 1.0, 'Planificación de la Seguridad', 722);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (386, 2.0, 'Fundamentos Digitales', 722);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (387, 3.0, 'Fundamentos Físicos', 722);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (388, 4.0, 'Crisis Digital', 722);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (389, 5.0, 'Crisis Física', 722);


-- Security Planning

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Identifique [amenazas](umbrella://assess-your-risk/security-planning/beginner) basándose en dónde se encuentra y en lo que hace',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Identifique [amenazas a la información](umbrella://information/managing-information/beginner) y cómo protegerla',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Haga un plan para [proteger su espacio de trabajo](umbrella://information/protect-your-workspace/beginner)',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Haga un plan de [seguridad en viaje](umbrella://travel/preparation/beginner)',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Evalúa su riesgo antes de cruzar [fronteras](umbrella://travel/borders/beginner)',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Prepárese para un viaje más seguro en [vehículo](umbrella://travel/vehicles/beginner)',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Reduzca su riesgo de [secuestro](umbrella://incident-response/kidnapping/beginner), [arresto](umbrella://incident-response/arrests/beginner), y [acoso sexual](umbrella://incident-response/sexual-assault/beginner)',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Prepárese para [cubrir](umbrella://work/protests/beginner) o [participar](umbrella://work/protests/advanced) en protestas',0,385);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Cree un plan de [evacuación](umbrella://incident-response/evacuation/beginner)',0,385);


-- Digital Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Asegure su [iPhone](umbrella://tools/encryption/s_encrypt-your-iphone.md) o [Android](umbrella://tools/other/s_android.md)',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Obtenga información sobre [HTTPS](umbrella://communications/email/beginner) y cómo usarlo en todas partes',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Utilice [contraseñas seguras](umbrella://information/passwords/beginner), [KeePassXC](umbrella://tools/encryption/s_keepassxc.md), y [2FA](umbrella://information/passwords/advanced)',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Use Signal para [mensajes](umbrella://communications/sending-a-message/beginner) y [llamadas](umbrella://communications/making-a-call/beginner) ([Android](umbrella://tools/messaging/s_signal-for-android.md) y [iOS](umbrella://tools/messaging/s_signal-for-ios.md))',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Eliminar](umbrella://information/safely-deleting/beginner), [Respaldar](umbrella://information/backing-up/advanced), [restaurar](umbrella://information/backing-up/advanced/s_accidental-file-deletion.md), o [encriptar](umbrella://information/protecting-files/beginner) files',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Elija software [open source](umbrella://information/malware/beginner) y [ajustes seguros](umbrella://information/protect-your-workspace/expert/s_software-and-settings.md)',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Defiéndase del [malware](umbrella://information/malware/advanced), [phishing](umbrella://communications/phishing/beginner), e [ingeniería social](umbrella://communications/phishing/beginner/s_social-engineering.md)',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Elige de manera informada la encriptación de [email](umbrella://communications/email/advanced)',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Privacidad en [redes sociales, blogs, y la nube](umbrella://communications/online-privacy/beginner)',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Proteja sus [metadatos](umbrella://communications/online-privacy/advanced/s_anonymity-online.md) con herramientas como [ObscuraCam](umbrella://tools/messaging/s_obscuracam.md)',0,386);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Use una [VPN](umbrella://communications/censorship/beginner/s_virtual-private-networks.md) para ocultar su ubicación o [Tor](umbrella://communications/online-privacy/advanced/s_tor.md) para proteger el anonimato ([Windows](umbrella://tools/tor/s_tor-for-windows.md), [Mac](umbrella://tools/tor/s_tor-for-mac-os-x.md), [Linux](umbrella://tools/tor/s_tor-for-linux.md))',0,386);


-- Physical Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Signos del [estrés](umbrella://stress/stress)',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Seguridad en ''[Hogar y Oficina](umbrella://information/protect-your-workspace)''',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Pros y contras de comunicación de [radio y teléfono satelital](umbrella://communications/radios-and-satellite-phones)',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Precauciones [médicas](umbrella://travel/preparation/beginner/s_medical.md) para el viaje',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Precauciones](umbrella://travel/borders/beginner) sencillas en ambientes hostiles',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Siempre [use cinturón de seguridad](umbrella://travel/vehicles/beginner/s_wear-a-seatbelt.md)',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Prepare una [pantalla](umbrella://travel/checkpoints/beginner)',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Establezca [códigos](umbrella://communications/mobile-phones/beginner/s_information-sent.md), [palabras de cohersión](umbrella://communications/radios-and-satellite-phones/beginner/s_radio-procedures.md), y [prueba de vida](umbrella://forms/f_proof-life-form.yml) para su equipo
',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Gestione las [relaciones](umbrella://work/public-communications) con autoridades, medios y el público',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Empaque para un [viaje](umbrella://travel/preparation/beginner), [vehículo](umbrella://travel/vehicles/beginner/s_drivers-and-vehicles.md), [casa segura](umbrella://incident-response/evacuation/beginner/s_safe-houses.md), o [bolso](umbrella://travel/protective-equipment/beginner) de emergencia
',0,387);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Equipo](umbrella://travel/protective-equipment/advanced) para condiciones extremas o de combate',0,387);


-- Digital Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Ha encontrado [malware](umbrella://information/malware) en su computadora',0,388);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Su email ha sido [hackeado](umbrella://communications/email)',0,388);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Censura](umbrella://communications/censorship) en Internet',0,388);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Tratando el [discurso de odio](umbrella://communications/online-abuse/advanced/s_hate-speech.md) en redes sociales',0,388);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Responder al chantaje, doxxing, robo de identidad, u otro [acoso online](umbrella://communications/online-abuse)',0,388);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Recibiendo un mensaje de [phishing](umbrella://communications/phishing/beginner) message',0,388);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Apoyo de Emergencia](umbrella://emergency-support/digital)',0,388);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Informar o registrar [incidentes de seguridad digital](umbrella://forms/f_digital-security-incident.yml)',0,388);


-- Physical Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Acercándose a una [frontera](umbrella://travel/borders/beginner)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Acercándose a un [puesto de control](umbrella://travel/checkpoints/beginner/s_on-approach.md)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Accidentes](umbrella://travel/vehicles/beginner/s_accidents.md) de vehículo',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Si es [secuestrado](umbrella://incident-response/kidnapping/advanced/s_if-you-are-kidnapped.md), [arrestado](umbrella://incident-response/arrests/beginner/s_if-you-are-arrested.md), o [acosado sexualmente](umbrella://incident-response/sexual-assault/advanced)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Si un miembro del equipo es [secuestrado](umbrella://incident-response/kidnapping/expert), [arrestado](umbrella://incident-response/arrests/advanced), o [acosado sexualmente](umbrella://incident-response/sexual-assault/expert)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Ser [seguido](umbrella://work/being-followed)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Cuándo [evacuar](umbrella://incident-response/evacuation/advanced)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[TEPT](umbrella://stress/stress/expert)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Apoyo de Emergencia](umbrella://emergency-support/physical/beginner)',0,389);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Reporte o registre [incidentes de seguridad física](umbrella://forms/f_physical-security-incident.yml)',0,389);



---------------------
------ Persian ------
---------------------

INSERT INTO "category" ('id', 'name', 'index', 'folder_name', 'deeplink', 'parent', 'language_id', 'description', 'icon', 'template') VALUES (724,'Pathways', -1.0, '', 'pathways', 0, 4,'','','');
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (395, 1.0, 'برنامه ریزی امنیتی', 724);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (396, 2.0, 'مبانی دیجیتال', 724);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (397, 3.0, 'مبانی فیزیکی', 724);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (398, 4.0, 'بحران دیجیتال', 724);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (399, 5.0, 'بحران فیزیکی', 724);


-- Security Planning

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[شناسایی تهدیدها](umbrella://assess-your-risk/security-planning/beginner) بر اساس جایی که هستید و کاری که انجام می دهید',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[شناسایی تهدیدها برای اطلاعات](umbrella://information/managing-information/beginner) و چگونگی محافظت از آنها',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[برنامه ریختن برای محافظت از فضای کاری](umbrella://information/protect-your-workspace/beginner)',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[برنامه ریختن برای امنیت سفر](umbrella://travel/preparation/beginner)',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[قبل از عبور خطر خود را ارزیابی کنید مرزها](umbrella://travel/borders/beginner)',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[آماده شدن برای سفر وسیله نقلیه](umbrella://travel/vehicles/beginner)',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[کاهش ریسک آدم ربایی](umbrella://incident-response/kidnapping/beginner), [دستگیر شدن](umbrella://incident-response/arrests/beginner), [تجاوز جنسی](umbrella://incident-response/sexual-assault/beginner)',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[آمادگی برای پوشش](umbrella://work/protests/beginner), [مشارکت](umbrella://work/protests/advanced) در تظاهرات',0,395);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[ایجاد یک تخلیه](umbrella://incident-response/evacuation/beginner) برنامه ریزی',0,395);


-- Digital Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[ایمن آی فون خود را](umbrella://tools/encryption/s_encrypt-your-iphone.md), [آندروید](umbrella://tools/other/s_android.md)',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('در مورد HTTPS یاد بگیرید [HTTPS](umbrella://communications/email/beginner) و در همه جا از آن استفاده کنید',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[از گذر واژه قوی گذرواژه قوی](umbrella://information/passwords/beginner) استفاده کنید. [KeePassXC](umbrella://tools/encryption/s_keepassxc.md), [2FA](umbrella://information/passwords/advanced)',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[از سیگنال برای پیام دادن](umbrella://communications/sending-a-message/beginner), [تماس ها](umbrella://communications/making-a-call/beginner) استفاده کنید ([آندروید](umbrella://tools/messaging/s_signal-for-android.md) و [iOS](umbrella://tools/messaging/s_signal-for-ios.md))',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[پاک کردن](umbrella://information/safely-deleting/beginner), [پشتیبان گیری](umbrella://information/backing-up/advanced), [بازگرداندن](umbrella://information/backing-up/advanced/s_accidental-file-deletion.md), [رمزنگار](umbrella://information/protecting-files/beginner) فایل ها',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[انتخاب منبع باز](umbrella://information/malware/beginner) و نرم افزار [تنظیمات امن](umbrella://information/protect-your-workspace/expert/s_software-and-settings.md)',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[دفاع از خود در برابر بدافزار](umbrella://information/malware/advanced), [فیشینگ](umbrella://communications/phishing/beginner), [مهندسی اجتماعی](umbrella://communications/phishing/beginner/s_social-engineering.md)',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[انتخابی آگاهانه در مورد رمزگذاری ایمیل](umbrella://communications/email/advanced)',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[حریم خصوصی بر روی رسانه های اجتماعی، وبلاگ ها و ابر](umbrella://communications/online-privacy/beginner)',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[محافظت از ابرداده](umbrella://communications/online-privacy/advanced/s_anonymity-online.md) با ابزارهایی مانند [ObscuraCam](umbrella://tools/messaging/s_obscuracam.md)',0,396);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('استفاده از [VPN](umbrella://communications/censorship/beginner/s_virtual-private-networks.md) برای مخفی کردن محل خود یا [تور](umbrella://communications/online-privacy/advanced/s_tor.md); ([برای محافظت از گمنامی خود ویندوز](umbrella://tools/tor/s_tor-for-windows.md), [مک](umbrella://tools/tor/s_tor-for-mac-os-x.md), [لینوکس](umbrella://tools/tor/s_tor-for-linux.md))',0,396);


-- Physical Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('علائم [استرس](umbrella://stress/stress)',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[خانه و دفتر](umbrella://information/protect-your-workspace) امنیت',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('جوانب مثبت و منفی [بی سیم و تلفن ماهواره ای](umbrella://communications/radios-and-satellite-phones) ارتباطات',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[پزشکی](umbrella://travel/preparation/beginner/s_medical.md) احتیاط برای سفر',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[ساده احتیاط](umbrella://travel/borders/beginner) در محیط های خصمانه',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('همیشه [کمبرند ایمنی را ببندید](umbrella://travel/vehicles/beginner/s_wear-a-seatbelt.md)',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('آماده کردن یک [داستان پوششی](umbrella://travel/checkpoints/beginner)',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('معین کردن[کدها](umbrella://communications/mobile-phones/beginner/s_information-sent.md), [کلمات اجبار](umbrella://communications/radios-and-satellite-phones/beginner/s_radio-procedures.md), [اثبات زنده بودن](umbrella://forms/f_proof-life-form.yml) برای تیم شما',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[مدیریت روابط](umbrella://work/public-communications) با مقامات، رسانه ها و مردم ',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[بسته بندی برای سفر](umbrella://travel/preparation/beginner), [وسیله نقلیه](umbrella://travel/vehicles/beginner/s_drivers-and-vehicles.md), [خانه امن](umbrella://incident-response/evacuation/beginner/s_safe-houses.md), [با اضطراری کیف دستی](umbrella://travel/protective-equipment/beginner)',0,397);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تجهیزات](umbrella://travel/protective-equipment/advanced) برای شرایط شدید یا مبارزه',0,397);


-- Digital Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('پیدا کردن [بدافزار](umbrella://information/malware) روی کامپیوتر شما',0,398);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('ایمل شما  [هک](umbrella://communications/email) شده است',0,398);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('اینترنت [سانسور](umbrella://communications/censorship)',0,398);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('مواجهه با [سخنان نفرت انگیز](umbrella://communications/online-abuse/advanced/s_hate-speech.md) روی رسانه اجتماعی',0,398);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('پاسخ دادن به باج خواهی، داکسینگ، جعل هویت و موارد دیگر [سو استفاده آنلاین](umbrella://communications/online-abuse)',0,398);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('دریافت یک پیام [فیشینگ](umbrella://communications/phishing/beginner) ',0,398);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[پشتیبانی اضطراری](umbrella://emergency-support/digital)',0,398);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('گزارش یا ضبط [حوادث امنیتی دیجیتال](umbrella://forms/f_digital-security-incident.yml)',0,398);


-- Physical Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[نزریک شدن به مرز](umbrella://travel/borders/beginner)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[نزدیک شدن به ایست بازرسی](umbrella://travel/checkpoints/beginner/s_on-approach.md)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[وسیله نقلیه تصادفات](umbrella://travel/vehicles/beginner/s_accidents.md)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[اگر شما ربوده شدید](umbrella://incident-response/kidnapping/advanced/s_if-you-are-kidnapped.md), [دستگیر شدید](umbrella://incident-response/arrests/beginner/s_if-you-are-arrested.md), [مورد تجاوز جنسی قرار گرفته](umbrella://incident-response/sexual-assault/advanced)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[اگر عضوی از تیم ربوده شد](umbrella://incident-response/kidnapping/expert), [دستگیر شد](umbrella://incident-response/arrests/advanced), [تجاوز جنسی](umbrella://incident-response/sexual-assault/expert)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تحت تعقیب شدن](umbrella://work/being-followed)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[هنگام تخلیه](umbrella://incident-response/evacuation/advanced)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[PTSD](umbrella://stress/stress/expert)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[پشتیبانی اورژانسی](umbrella://emergency-support/physical/beginner)',0,399);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[گزارش یا ضبط حوادث امنیتی فیزیکی](umbrella://forms/f_physical-security-incident.yml)',0,399);



---------------------
------ Russian ------
---------------------

INSERT INTO "category" ('id', 'name', 'index', 'folder_name', 'deeplink', 'parent', 'language_id', 'description', 'icon', 'template') VALUES (725,'Pathways', -1.0, '', 'pathways', 0, 5,'','','');
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (400, 1.0, 'Планирование безопасности', 725);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (401, 2.0, 'Цифровой базис', 725);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (402, 3.0, 'Физический базис', 725);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (403, 4.0, 'Цифровой кризис', 725);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (404, 5.0, 'Физический кризис', 725);


-- Security Planning

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Выявление [угроз](umbrella://assess-your-risk/security-planning/beginner) в зависимости от того, где вы находитесь и чем занимаетесь',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Выявление [угроз для информации](umbrella://information/managing-information/beginner) и как ее защитить',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Составление плана [защиты вашего рабочего пространства](umbrella://information/protect-your-workspace/beginner)',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Cоставление плана [безопасной поездки](umbrella://travel/preparation/beginner)',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Оценку своего риска перед пересечением [границы](umbrella://travel/borders/beginner)',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Подготовку более безопасного [транспортного средства](umbrella://travel/vehicles/beginner)',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Уменьшение риска [похищения людей](umbrella://incident-response/kidnapping/beginner), [ареста](umbrella://incident-response/arrests/beginner) и [сексуального насилия](umbrella://incident-response/sexual-assault/beginner)',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Подготовку [прикрытия](umbrella://work/protests/beginner) или [участия](umbrella://work/protests/advanced) в протестах',0,400);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Создание плана [эвакуации](umbrella://incident-response/evacuation/beginner)',0,400);

-- Digital Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Защиту своего [iPhone](umbrella://tools/encryption/s_encrypt-your-iphone.md) или [Android](umbrella://tools/other/s_android.md)',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Знания о [HTTPS](umbrella://communications/email/beginner) и используйте его везде',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Использование [надежных паролей](umbrella://information/passwords/beginner), [KeePassXC](umbrella://tools/encryption/s_keepassxc.md) и [двухфакторную аутентификацию](umbrella://information/passwords/advanced)',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Использование Signal для [обмена сообщениями](umbrella://communications/sending-a-message/beginner) и [вызовов](umbrella://communications/making-a-call/beginner) (на [Android](umbrella://tools/messaging/s_signal-for-android.md) и [iOS](umbrella://tools/messaging/s_signal-for-ios.md))',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Удаление](umbrella://information/safely-deleting/beginner), [резервное копирование](umbrella://information/backing-up/advanced), [восстановление](umbrella://information/backing-up/advanced/s_accidental-file-deletion.md) или [шифрование](umbrella://information/protecting-files/beginner) файлов',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Выберите программное обеспечение [open source](umbrella://information/malware/beginner) и [безопасные настройки](umbrella://information/protect-your-workspace/expert/s_software-and-settings.md)',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Защиту от [вредоносных программ](umbrella://information/malware/advanced), [фишинга](umbrella://communications/phishing/beginner), и [социальной инженерии](umbrella://communications/phishing/beginner/s_social-engineering.md)',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Осознанный выбор в отношении шифрования [e-mail](umbrella://communications/email/advanced)',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Конфиденциальность в [социальных сетях, блогах и облаке](umbrella://communications/online-privacy/beginner)',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Защиту своих [метаданных](umbrella://communications/online-privacy/advanced/s_anonymity-online.md) с такими инструментами, как [ObscuraCam](umbrella://tools/messaging/s_obscuracam.md)',0,401);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Использование [VPN](umbrella://communications/censorship/beginner/s_virtual-private-networks.md), чтобы скрыть ваше местоположение, или [Tor](umbrella://communications/online-privacy/advanced/s_tor.md) для защиты вашей анонимности при ([Windows](umbrella://tools/tor/s_tor-for-windows.md), [Mac](umbrella://tools/tor/s_tor-for-mac-os-x.md), [Linux](umbrella://tools/tor/s_tor-for-linux.md))',0,401);


-- Physical Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Признаки [стресса](umbrella://stress/stress)',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Дом и офис](umbrella://information/protect-your-workspace) на безопасность',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Плюсы и минусы [радио и спутниковой связи](umbrella://communications/radios-and-satellite-phones)',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Медицинские](umbrella://travel/preparation/beginner/s_medical.md) меры предосторожности при поездках',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Простые [меры предосторожности](umbrella://travel/borders/beginner) в агрессивных средах',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Всегда [пристегивайте ремень безопасности](umbrella://travel/vehicles/beginner/s_wear-a-seatbelt.md)',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Подготовка [истории прикрытия](umbrella://travel/checkpoints/beginner)',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Установление [кодов](umbrella://communications/mobile-phones/beginner/s_information-sent.md), [слов принуждения](umbrella://communications/radios-and-satellite-phones/beginner/s_radio-procedures.md) и [доказательства жизни](umbrella://forms/f_proof-life-form.yml) для вашей команды',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Управление [отношениями](umbrella://work/public-communications) с властями, средствами массовой информации и общественностью',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Сумку для [поездки](umbrella://travel/preparation/beginner), [транспортное средство](umbrella://travel/vehicles/beginner/s_drivers-and-vehicles.md), [безопасное жилье](umbrella://incident-response/evacuation/beginner/s_safe-houses.md) или аварийную [экстренную сумку](umbrella://travel/protective-equipment/beginner)',0,402);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Оборудование](umbrella://travel/protective-equipment/advanced) для экстремальных или боевых условий',0,402);


-- Digital Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Если вы обнаружили [вредоносное ПО](umbrella://information/malware) на своем компьютере',0,403);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Если ваш электронный адрес [взломан](umbrella://communications/email)',0,403);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Интернет-цензура](umbrella://communications/censorship)',0,403);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Работу с [ненавистническими высказываниями](umbrella://communications/online-abuse/advanced/s_hate-speech.md) в социальных сетях',0,403);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Ответ на шантаж, клевету, кражу личных данных или другие [онлайн-злоупотребления](umbrella://communications/online-abuse)',0,403);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Получение [фишинг-сообщений](umbrella://communications/phishing/beginner)',0,403);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Поддержку в чрезвычайной ситуации](umbrella://emergency-support/digital)',0,403);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Отчеты или записи [инцидентов цифровой безопасности](umbrella://forms/f_digital-security-incident.yml)',0,403);


-- Physical Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Приближение к [границе](umbrella://travel/borders/beginner)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Приближение к [контрольной точке](umbrella://travel/checkpoints/beginner/s_on-approach.md)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Транспортное средство и [ДТП](umbrella://travel/vehicles/beginner/s_accidents.md)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Если вы [похищены](umbrella://incident-response/kidnapping/advanced/s_if-you-are-kidnapped.md), [арестованы](umbrella://incident-response/arrests/beginner/s_if-you-are-arrested.md) или [подверглись сексуальному насилию](umbrella://incident-response/sexual-assault/advanced)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Если член команды [похищен](umbrella://incident-response/kidnapping/expert), [арестован](umbrella://incident-response/arrests/advanced) или [подвергся сексуальному насилию](umbrella://incident-response/sexual-assault/expert)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Под наблюдением](umbrella://work/being-followed)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Когда [эвакуироваться](umbrella://incident-response/evacuation/advanced)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[ПТСР](umbrella://stress/stress/expert)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[Поддержку в чрезвычайной ситуации](umbrella://emergency-support/physical/beginner)',0,404);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('Отчеты или записи [инцидентов физической безопасности](umbrella://forms/f_physical-security-incident.yml)',0,404);



---------------------
------ Chinese ------
---------------------

INSERT INTO "category" ('id', 'name', 'index', 'folder_name', 'deeplink', 'parent', 'language_id', 'description', 'icon', 'template') VALUES (726,'Pathways', -1.0, '', 'pathways', 0, 6,'','','');
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (405, 1.0, '安全計劃', 726);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (406, 2.0, '數字基礎', 726);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (407, 3.0, '物理基礎', 726);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (408, 4.0, '數字危機', 726);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (409, 5.0, '物理危機', 726);


-- Security Planning

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('根據您所處的位置以及您的工作確定[威脅](umbrella://assess-your-risk/security-planning/beginner)',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('識別 [信息威脅](umbrella://information/managing-information/beginner) 以及如何保護它',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('制定計劃來 [保護您的工作空間](umbrella://information/protect-your-workspace/beginner)',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('制定 [旅行安全](umbrella://travel/preparation/beginner) 計劃',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('在越過 [邊界](umbrella://travel/borders/beginner) 之前評估您的風險',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('準備更安全的[車輛](umbrella://travel/vehicles/beginner) 旅行',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('降低 [綁架](umbrella://incident-response/kidnapping/beginner) 的風險， [逮捕](umbrella://incident-response/arrests/beginner) 和 [性侵犯](umbrella://incident-response/sexual-assault/beginner)',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('在抗議活動中做好[掩護]umbrella://work/protests/beginner) 或[參與](umbrella://work/protests/advanced)的準備',0,405);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('創建 [疏散](umbrella://incident-response/evacuation/beginner) 計劃',0,405);


-- Digital Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('保護你的[iPhone](umbrella://tools/encryption/s_encrypt-your-iphone.md) 或[Android](umbrella://tools/other/s_android.md)',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('了解[HTTPS](umbrella://communications/email/beginner)並在任何地方使用它',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('使用[強密碼](umbrella://information/passwords/beginner)， [KeePassXC](umbrella://tools/encryption/s_keepassxc.md), 和 [2FA](umbrella://information/passwords/advanced)',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('使用Signal進行[消息傳遞](umbrella://communications/sending-a-message/beginner) 和 [呼叫](umbrella://communications/making-a-call/beginner) ([安卓](umbrella://tools/messaging/s_signal-for-android.md) 和 [iOS](umbrella://tools/messaging/s_signal-for-ios.md))',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[刪除](umbrella://information/safely-deleting/beginner)，[備份](umbrella://information/backing-up/advanced)， [還原](umbrella://information/backing-up/advanced/s_accidental-file-deletion.md) 或 [加密](umbrella://information/protecting-files/beginner) 文件',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('選擇 [開源](umbrella://information/malware/beginner) 軟件和 [安全設置](umbrella://information/protect-your-workspace/expert/s_software-and-settings.md)',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('保護自己免受[惡意軟件](umbrella://information/malware/advanced)，[網絡釣魚](umbrella://communications/phishing/beginner) 攻擊， 和[社會工程]umbrella://communications/phishing/beginner/s_social-engineering.md)',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('對[電子郵件](umbrella://communications/email/advanced) 加密做出明智的選擇',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[社交媒體，博客和雲端](umbrella://communications/online-privacy/beginner) 的隱私權',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('保護您的[元數據](umbrella://communications/online-privacy/advanced/s_anonymity-online.md) 使用像[ObscuraCam]這樣的工具(umbrella://tools/messaging/s_obscuracam.md)',0,406);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('使用[VPN](umbrella://communications/censorship/beginner/s_virtual-private-networks.md) 來隱藏您的位置或 [Tor](umbrella://communications/online-privacy/advanced/s_tor.md) 可保護您的匿名性([Windows](umbrella://tools/tor/s_tor-for-windows.md)， [Mac](umbrella://tools/tor/s_tor-for-mac-os-x.md), [Linux](umbrella://tools/tor/s_tor-for-linux.md))',0,406);


-- Physical Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[壓力](umbrella://stress/stress)跡象',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[家庭和辦公室](umbrella://information/protect-your-workspace)安全',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[無線電和衛星電話](umbrella://communications/radios-and-satellite-phones) 通信的利弊',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[醫療](umbrella://travel/preparation/beginner/s_medical.md) 旅行預防措施',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('在惡劣環境中的簡單[預防措施](umbrella://travel/borders/beginner)',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('始終[係上安全帶](umbrella://travel/vehicles/beginner/s_wear-a-seatbelt.md)',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('準備一個[封面故事](umbrella://travel/checkpoints/beginner)',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('為您的團隊制定[代碼](umbrella://communications/mobile-phones/beginner/s_information-sent.md)，[脅迫詞](umbrella://communications/radios-and-satellite-phones/beginner/s_radio-procedures.md) 和 [證明生命](umbrella://forms/f_proof-life-form.yml) n',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('與當局，媒體和公眾管理[關係](umbrella://work/public-communications)',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('打包[旅行](umbrella://travel/preparation/beginner)，[車輛](umbrella://travel/vehicles/beginner/s_drivers-and-vehicles.md)，[安全屋](umbrella://incident-response/evacuation/beginner/s_safe-houses.md)，或緊急[逃生包](umbrella://travel/protective-equipment/beginner) n',0,407);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('適用於極端或戰鬥條件的[設備](umbrella://travel/protective-equipment/advanced)',0,407);


-- Digital Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('您在計算機上發現[惡意軟件](umbrella://information/malware)',0,408);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('您的電子郵件已被[黑客入侵](umbrella://communications/email)',0,408);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('互聯網[審查](umbrella://communications/censorship)',0,408);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('在社交媒體上處理[仇恨言論](umbrella://communications/online-abuse/advanced/s_hate-speech.md)',0,408);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('回應勒索，欺騙，身份盜竊或其他[在線濫用](umbrella://communications/online-abuse)',0,408);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('接收[網絡釣魚](umbrella://communications/phishing/beginner)消息',0,408);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[緊急支援](umbrella://emergency-support/digital)',0,408);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('報告或記錄[數字安全事件](umbrella://forms/f_digital-security-incident.yml',0,408);


-- Physical Crisis


INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('接近[邊界](umbrella://travel/borders/beginner)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('接近[檢查點](umbrella://travel/checkpoints/beginner/s_on-approach.md)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('車禍[事故](umbrella://travel/vehicles/beginner/s_accidents.md)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('如果你[被綁架](umbrella://incident-response/kidnapping/advanced/s_if-you-are-kidnapped.md)， [被捕](umbrella://incident-response/arrests/beginner/s_if-you-are-arrested.md)，或[性侵犯](umbrella://incident-response/sexual-assault/advanced)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('如果團隊成員被[綁架](umbrella://incident-response/kidnapping/expert)， [被捕](umbrella://incident-response/arrests/advanced)，或[性侵犯](umbrella://incident-response/sexual-assault/expert)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('被[跟蹤](umbrella://work/being-followed)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('何時[撤離](umbrella://incident-response/evacuation/advanced)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[PTSD](umbrella://stress/stress/expert)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[緊急支援](umbrella://emergency-support/physical/beginner)',0,409);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('報告或記錄[物理安全事件](umbrella://forms/f_physical-security-incident.yml)',0,409);



---------------------
------ Arabic ------
---------------------

INSERT INTO "category" ('id', 'name', 'index', 'folder_name', 'deeplink', 'parent', 'language_id', 'description', 'icon', 'template') VALUES (723,'Pathways', -1.0, '', 'pathways', 0, 1,'','','');
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (390, 1.0, 'التخطيط الأمني', 723);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (391, 2.0, 'الأساسيات الرقمية', 723);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (392, 3.0, 'الأساسيات المادية', 723);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (393, 4.0, 'الأزمة الرقمية', 723);
INSERT INTO "checklist" ('id', 'index', 'name', 'category_id') VALUES (394, 5.0, 'الأزمة الجسدية',723);


-- Security Planning

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تحديد التهديدات](umbrella://assess-your-risk/security-planning/beginner) فيما يتعلق أين أنت وعملك',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تحديد تهديدات المعلومات](umbrella://information/managing-information/beginner) وتعلم لحماية المعلومات ',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[ضع خطة لحماية مساحة العمل الخاصة بك](umbrella://information/protect-your-workspace/beginner)',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[ضع خطة أمنية للسفر](umbrella://travel/preparation/beginner)',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تقييم المخاطر الخاصة بك قبل عبور الحدود](umbrella://travel/borders/beginner)',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[على استعداد للسفر أكثر أمانا مع المركبات](umbrella://travel/vehicles/beginner)',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[قلل من خطر الاختطاف](umbrella://incident-response/kidnapping/beginner), [يقبض على](umbrella://incident-response/arrests/beginner), [أو الوقوع ضحية اعتداء جنسي](umbrella://incident-response/sexual-assault/beginner)',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[الاستعداد للعمل في الاحتجاجات](umbrella://work/protests/beginner) [أو المشاركة فيها](umbrella://work/protests/advanced)',0,390);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[إنشاء خطة الإخلاء](umbrella://incident-response/evacuation/beginner)',0,390);

-- Digital Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('قم بتأمين [iPhone](umbrella://tools/encryption/s_encrypt-your-iphone.md) أو [Android](umbrella://tools/other/s_android.md)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('تعرف على [HTTPS](umbrella://communications/email/beginner) واستخدامها في كل مكان',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[استخدام كلمات مرور قوية](umbrella://information/passwords/beginner), [KeePassXC](umbrella://tools/encryption/s_keepassxc.md), [2FA](umbrella://information/passwords/advanced)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[استخدم Signal للمراسلة](umbrella://communications/sending-a-message/beginner), [إتصالات هاتفية](umbrella://communications/making-a-call/beginner) على [Android](umbrella://tools/messaging/s_signal-for-android.md), [iOS](umbrella://tools/messaging/s_signal-for-ios.md)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[حذف](umbrella://information/safely-deleting/beginner), [كفل](umbrella://information/backing-up/advanced), [استعادة](umbrella://information/backing-up/advanced/s_accidental-file-deletion.md), [تشفير](umbrella://information/protecting-files/beginner) ملفات',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[اختيار البرمجيات مفتوحة المصدر](umbrella://information/malware/beginner), [استخدام إعدادات آمنة](umbrella://information/protect-your-workspace/expert/s_software-and-settings.md)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تدافع عن نفسك من البرامج الضارة](umbrella://information/malware/advanced), [التصيد](umbrella://communications/phishing/beginner), [هندسة اجتماعية](umbrella://communications/phishing/beginner/s_social-engineering.md)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[اتخاذ قرار مستنير حول البريد الإلكتروني](umbrella://communications/email/advanced) encryption',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[الخصوصية على وسائل التواصل الاجتماعي والمدونات والسحابة](umbrella://communications/online-privacy/beginner)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[حماية البيانات الوصفية الخاصة بك](umbrella://communications/online-privacy/advanced/s_anonymity-online.md) مع أدوات مثل [ObscuraCam](umbrella://tools/messaging/s_obscuracam.md)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[استخدم VPN لإخفاء موقعك](umbrella://communications/censorship/beginner/s_virtual-private-networks.md)',0,391);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[استخدم Tor لحماية غموضك](umbrella://communications/online-privacy/advanced/s_tor.md); ([Windows](umbrella://tools/tor/s_tor-for-windows.md), [Mac](umbrella://tools/tor/s_tor-for-mac-os-x.md), [Linux](umbrella://tools/tor/s_tor-for-linux.md))',0,391);


-- Physical Basics

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[علامات الإجهاد](umbrella://stress/stress)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[أمن المنزل والمكتب](umbrella://information/protect-your-workspace)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[فوائد ومخاطر الاتصال عبر الراديو والهاتف عبر الأقمار الصناعية](umbrella://communications/radios-and-satellite-phones)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[الاحتياطات الطبية للسفر](umbrella://travel/preparation/beginner/s_medical.md)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[احتياطات بسيطة في بيئات معادية](umbrella://travel/borders/beginner)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[دائما ارتداء حزام الأمان](umbrella://travel/vehicles/beginner/s_wear-a-seatbelt.md)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تحضير قصة الغلاف](umbrella://travel/checkpoints/beginner)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[إنشاء كلمات مشفرة](umbrella://communications/mobile-phones/beginner/s_information-sent.md), [الكلمات عندما تكون في ورطة](umbrella://communications/radios-and-satellite-phones/beginner/s_radio-procedures.md), [والدليل على أنك على قيد الحياة](umbrella://forms/f_proof-life-form.yml)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[إدارة العلاقات](umbrella://work/public-communications) مع السلطات ووسائل الإعلام والجمهور',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[حزمة لرحلة](umbrella://travel/preparation/beginner),  [مركبة](umbrella://travel/vehicles/beginner/s_drivers-and-vehicles.md), [منزل امن](umbrella://incident-response/evacuation/beginner/s_safe-houses.md), [أو كيس انتزاع الطوارئ](umbrella://travel/protective-equipment/beginner)',0,392);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[معدات](umbrella://travel/protective-equipment/advanced) للظروف القاسية أو القتالية',0,392);

-- Digital Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[لقد وجدت برامج ضارة](umbrella://information/malware) على جهاز الكمبيوتر الخاص بك',0,393);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تم اختراق البريد الإلكتروني الخاص بك](umbrella://communications/email)',0,393);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[الإنترنت رقابة](umbrella://communications/censorship)',0,393);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[التعامل مع خطاب الكراهية](umbrella://communications/online-abuse/advanced/s_hate-speech.md) على وسائل التواصل الاجتماعي',0,393);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('الاستجابة للابتزاز أو, doxxing, [أو سرقة الهوية أو غير ذلك من إساءة الاستخدام عبر الإنترنت](umbrella://communications/online-abuse)',0,393);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('تلقي رسالة [phishing](umbrella://communications/phishing/beginner)',0,393);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[دعم الطوارئ](umbrella://emergency-support/digital)',0,393);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[الإبلاغ عن أو تسجيل حوادث الأمان الرقمية](umbrella://forms/f_digital-security-incident.yml)',0,393);


-- Physical Crisis

INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تقترب من الحدود](umbrella://travel/borders/beginner)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[تقترب من نقطة تفتيش](umbrella://travel/checkpoints/beginner/s_on-approach.md)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[حوادث المركبات](umbrella://travel/vehicles/beginner/s_accidents.md)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[إذا تم اختطافك](umbrella://incident-response/kidnapping/advanced/s_if-you-are-kidnapped.md), [القى القبض](umbrella://incident-response/arrests/beginner/s_if-you-are-arrested.md), [أو ضحية الاعتداء الجنسي](umbrella://incident-response/sexual-assault/advanced)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[إذا تم اختطاف عضو في الفريق](umbrella://incident-response/kidnapping/expert), [القى القبض](umbrella://incident-response/arrests/advanced), [أو ضحية الاعتداء الجنسي](umbrella://incident-response/sexual-assault/expert)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[يجري اتباعها](umbrella://work/being-followed)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[متى يتم الإخلاء؟](umbrella://incident-response/evacuation/advanced)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[PTSD](umbrella://stress/stress/expert)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[دعم الطوارئ](umbrella://emergency-support/physical/beginner)',0,394);
INSERT INTO "check_item" ('name', 'is_label', 'checklist_id') VALUES ('[الإبلاغ عن أو تسجيل حوادث الأمان الجسدي](umbrella://forms/f_physical-security-incident.yml)',0,394);



