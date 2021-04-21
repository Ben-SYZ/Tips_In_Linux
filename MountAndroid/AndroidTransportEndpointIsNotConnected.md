This typically is caused by the mount directory being left mounted due to a crash of your filesystem. Go to the parent directory of the mount point and enter `fusermount -u YOUR_MNT_DIR`.

If this doesn't do the trick, do `sudo umount -l YOUR_MNT_DIR`.

[https://stackoverflow.com/questions/16002539/fuse-error-transport-endpoint-is-not-connected/19920009#19920009?newreg=83dd67b3f6c3490d96caa369db513117](https://stackoverflow.com/questions/16002539/fuse-error-transport-endpoint-is-not-connected/19920009#19920009?newreg=83dd67b3f6c3490d96caa369db513117)
