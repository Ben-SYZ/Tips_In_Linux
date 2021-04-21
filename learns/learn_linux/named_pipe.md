https://stackoverflow.com/questions/5998126/send-command-to-a-background-process
https://www.linuxjournal.com/content/using-named-pipes-fifos-bash

 A more complex example might be if you have a backup that wakes up every hour or so and reads a named pipe to see if it should run. You then could write something to the pipe each time you've made a lot of changes to the files you want to back up. You might even write the names of the files that you want backed up to the pipe so the backup doesn't have to check everything.
