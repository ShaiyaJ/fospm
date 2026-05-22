# fospm
The **f**ree **o**ffline **s**ynced **p**assword **m**anager.


## About
Fospm is a command line utility that generates secure passwords. It's deterministic meaning that these passwords are *algorithmically* synced across devices. 

This is primarily for people who don't feel comfortable giving away personal information or money to password managers. This won't store secrets. 

> [!WARNING]  
> As this program is deterministic, you can end up with the same password as someone else if you don't take enough care into setting a globally unique master password.
> You won't know if your master password is globally unique - but you can give it a good shot. My recommendation is to follow general common sense.
> Have a high amount of characters to mitigate brute force attacks and (if you want to do things like [this](https://xkcd.com/936/)) use uncommon dictionary words to mitigate dictionary attacks.
> The name of the service is also an area where you can trip up - I recommend using the URL of the service since that will stay the same (watch out for trailing slashes!)


## Use
**This software should be seen as more proof of concept!** It isn't particularly secure. This was a way for me to learn haskell more than it was a way to actually generate viable passwords. I may work on a version of this software that is more targeted towards actual use (I'll probably aim to use a reputable hashing algorithm instead of rolling my own XOR hashing).

### Compiling
1. **Ensure you clone the version that made your passwords on** (incase there are changes to the underlying algorithm)
2. Compile `main.hs` using [ghc](https://www.haskell.org/ghc/) 

This program is untested on Windows machines.

### Obtain a password
When you the run the program you will be prompted for your master password. You will only have to put this in once.

Then you will be prompted for a "service name" and a "user name". This will generate 3 passwords. Some services may not allow you to use some special characters - so these 3 provide different ranges of characters. The first is always the most secure, the second and third are less secure but will work on more services.

You can write `"quit"` inside of the service name section in order to end the application or use `Ctrl + C`.

### Staying secure
1. Ensure that you use a master password that is truly unique to you
2. Ensure services that you use these passwords with store a hash of the passwords - if you sign up to services that store the passwords in plaintext then it may be possible for an attacker to reconstruct your master password


## Contributing
I'm not maintaining this project actively. I'll only update it when I want a new feature.

Part of this project was to help me learn haskell. I know I've probably made some mistakes or done things incorrectly, and I would love suggestions on improving my haskell. 

Otherwise, I don't think this really *should* be used given the security issues.
