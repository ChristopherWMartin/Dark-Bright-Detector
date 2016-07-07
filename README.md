# Dark/Bright Detector

When run, darkBrightDetect.sh iterates through a directory of images and allows the user to act on those that contain a greater than desired percentage of pure black or white pixels (defined in the 'definedThreshhold' variable (the default being 0.8 -- 80%)).

darkBrightDetect.sh can be run periodically as a cron job by editing your users crontab file

```
crontab -e
```

and adding a new job for the script

```
* * * * * /path/to/darkBrightDetect.sh
```

The above will, for example, run the script once every minute.

This script depends on 'ImageMagick' and 'bc'. Both of which are installed by default on most Linux distributions.