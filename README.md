# X-MOD
This is X-MOD, a mod table reader for OpenITG and NotITG.

To use as a standalone mod reader:
1) Download the X-MOD repository.
2) Place all of the X-MOD files in `/yoursongname/lua/`.
3) In your `.sm` file, set FGCHANGES to this value: `#FGCHANGES:0.000=lua=1.000=0=0=0=====;`.

To run with another mod reader:
1) Set up your alternative mod reader of choice.
2) Download the X-MOD repository.
3) Place all of the X-MOD files in `/yoursongname/lua/x-mod/`.
4) In your mod reader's `default.xml`, add `<Layer File="x-mod/default.xml"/>`.
5) In X-MOD's `default.xml`, remove this line: `queuecommand('Update')`.
6) At the end of your mod reader's Update Command, add the line `xero.update_command()`.

After you've set up X-MOD, you can add mods via `xero.add_mod()` in `mods.lua` and put actor definitions in `actors.xml`.
