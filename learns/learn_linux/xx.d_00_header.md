https://unix.stackexchange.com/questions/134520/what-is-the-number-prefix-in-config-files-from-d-directory

It's a convention used both to keep filenames unique, and to control the order in which scripts get executed. In general, the xx.d directories are scanned by something doing the moral equivalent of for file in /etc/grub.d/*; do ... and the numeric prefixes give this an ordering other than alphabetical. There may be application-specific standards for what's a 4x_foo vs a 9x_foo but nothing consistent across all the xx.d directories.


