https://askubuntu.com/questions/442843/what-are-duty-of-locale-and-locale-gen-commands

**Compiled locale files** take about 50MB of disk space, and most users only need few locales. In order to save disk space, compiled locale files are not distributed in the locales package, but selected locales are automatically generated when this package is installed by running the locale-gen program.

When you run locale-gen or locale-gen <locale code> you compile the needed locale file(s), allowing commands to use the locale specified within the environments variables displayed by locale.
