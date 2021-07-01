* `$(...)` means execute the command in the parens in a subshell and return its stdout. Example:
    ```sh
    $ echo "The current date is $(date)"
    ```
    The current date is Mon Jul  6 14:27:59 PDT 2015

* `(...)` means run the commands listed in the parens in a subshell. Example:
    ```sh
    $ a=1; (a=2; echo "inside: a=$a"); echo "outside: a=$a"
    inside: a=2
    outside: a=1
    ```

* `$((...))` means perform arithmetic and return the result of the calculation. Example:
    ```sh
    $ a=$((2+3)); echo "a=$a"
    a=5
    ```

* `((...))` means perform arithmetic, possibly changing the values of shell variables, but don't return its result. Example:
    ```sh
    $ ((a=2+3)); echo "a=$a"
    a=5
    ```

* `${...}` means return the value of the shell variable named in the braces. Example:
    ```sh
    $ echo ${SHELL}
    /bin/bash
    ```

* `{...}` means execute the commands in the braces as a group. Example:
    ```sh
    $ false || { echo "We failed"; exit 1; }
    We failed
    ```

