# XeroOl's Mod Loader
This is XeroOl's Mod Loader, a mod table reader for OpenITG and NotITG.

To use as a standalone mod reader:
1) Download the XeroOl's Mod Loader repository.
2) Place all of the XeroOl's Mod Loader files in `/yoursongname/lua/`.
3) In your `.sm` file, set FGCHANGES to this value: `#FGCHANGES:0.000=lua=1.000=0=0=0=====;`.

To run with another mod reader:
1) Set up your alternative mod reader of choice.
2) Download the XeroOl's Mod Loader repository.
3) Copy the `xero/` folder from this repository into `/yoursongname/lua/xero/`.
4) In your mod reader's `default.xml`, add the line `<Layer File="xero/default.xml"/>`.
5) At the end of your mod reader's Update Command, add the line `xero.update_command(true)`.

After you've set up XeroOl's Mod Loader, you can add mods via `xero.add_mod()` in `mods.lua` and put actor definitions in `actors.xml`.
