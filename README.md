# PewPew
This is uni project , my very first game ever :)

Using lua proggraming languange and LOVE game engine,
Made with assets from http://kenney.nl/ credits to Kenney

  Assets are licensed as CC0 
	License (Creative Commons Zero, CC0)
	http://creativecommons.org/publicdomain/zero/1.0/

Game made from idea LOVE tutorial
http://osmstudios.com/tutorials/your-first-love2d-game-in-200-lines-part-1-of-3


Windows supports creation of zip files out of the box

To create your game executable under windows use the command line to run

   copy /b love.exe+SuperGame.love SuperGame.exe
   
Note: You may have to run the command as an administrator on your computer. You can do this by going to Windows\System32 and right clicking on cmd.exe and selecting the option Run as administrator. After this, you must type cd C:\Program Files\LOVE\ (or whatever your default love directory is), then you may continue as normal.

Alternatively you can create a .bat (e.g. create_game_exe.bat) file with the contents

   copy /b love.exe+%1 "%~n1.exe"
   
and then you can simply drag your SuperGame.love file onto the .bat file and it will create the file SuperGame.love.exe which you could then use for distribution.

This method creates a fused game.

When distributing the windows executable you will need to include the dll files that came in the folder of the love.exe you used (so don't mix the 32 bit dll's with the 64 bit dll's). Without these files you will get error message when attempting to run SuperGame.exe on a windows machine.

The contents of your final distribution folder should look something like this:

SDL2.dll
OpenAL32.dll (note: this file is different in the 64 bit download despite still being called 'OpenAL32.dll')
SuperGame.exe
license.txt (note: the license requires that it be included in any further distribution)
DevIL.dll
love.dll
lua51.dll
mpg123.dll
msvcp110.dll
msvcr110.dll


