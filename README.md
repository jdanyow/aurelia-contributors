# aurelia-contributors

A powershell script that generates the Aurelia Contributors video: https://www.danyow.net/aurelia-contributors/

## setup

1. Install gource: http://gource.io/
2. Download ffmpeg... the powershell script expects it to be at `C:\ffmpeg\bin\ffmpeg` but you can put it anywhere you want and update the script accordingly.
3. Clone this repo and cd into it using PowerShell
4. Execute `& ./gource.ps1`

The Aurelia git repos will be cloned, commit scraped, contributors counted and gourced. End result is an mp4 file.

## adding milestones

Open captions.js and edit the milestones array. Timestamps are in unix format.

## repo list

https://gist.run/?id=ff92973fe9ec1565be3ffaf25405dd84
