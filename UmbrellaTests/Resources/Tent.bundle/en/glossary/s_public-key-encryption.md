---
title: Public key encryption
---
# Public key encryption

Traditional encryption systems use the same secret, or key, to encrypt and decrypt a message. So if I encrypted a file with the password "bluetonicmonster", you would need both the file and the secret "bluetonicmonster" to decode it. Public key encryption uses two keys: one to encrypt, and other to decrypt. This has all kinds of useful consequences. For one, it means that you can hand out the key to encrypt messages to you, and as long as you keep the other key secret, anyone with that key can talk to you securely. The key you hand out widely is known as the "public key": hence the name of the technique. Public key encryption is used to encrypt email and files by Pretty Good Privacy  (PGP), OTR for instant messaging, and SSL/TLS for web browsing.