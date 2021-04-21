find ./ -type f -exec chmod a-x {} +

https://stackoverflow.com/questions/5119946/find-exec-with-multiple-commands

```sh
find . -name "*.txt" -exec echo {} \; -exec grep banana {} \;
```

Note that in this case the second command will only run if the first one returns successfully, as mentioned by @Caleb. If you want both commands to run regardless of their success or failure, you could use this construct:

```sh
find . -name "*.txt" \( -exec echo {} \; -o -exec true \; \) -exec grep banana {} \;
```

**so actually, `-exec` is also a test like `-name`, if true then run the left parameter**
