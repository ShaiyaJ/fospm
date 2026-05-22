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
1. **Ensure you clone the version that made your passwords on** (incase there are changes to the underlying algorithm)
2. Compile `main.hs` using [ghc](https://www.haskell.org/ghc/) 

This program is untested on Windows machines.


## Contributing
I'm not maintaining this project actively. I'll only update it when I want a new feature.

Part of this project was to help me learn haskell. I know I've probably made some mistakes or done things incorrectly, and I would love suggestions on improving the program. Please make issues or pull requests!

A "pretty please" when contributing would be to try and not change the output values of the password generation function. This would invalidate every password made on the program, which would be very annoying. If there's a security issue, however, then that is an exception. 
