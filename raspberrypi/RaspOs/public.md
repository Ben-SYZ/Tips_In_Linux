#https://stackoverflow.com/questions/21498667/how-to-limit-user-commands-in-linux

1. Change the user shell to restricted bash
```sh
chsh -s /bin/rbash <username>
```
2. Create a bin directory under the user home directory

```sh
sudo mkdir /home/<username>/bin
sudo chmod 755 /home/<username>/bin
```

3. Change the user's default PATH to the bin directory

```sh
echo "PATH=$HOME/bin" >> /home/<username>/.bashrc
echo "export PATH >> /home/<username>/.bashrc
```

4. Create symlinks of the command(s) that the user require

```sh
sudo ln -s /bin/<command> /home/<username>/bin/
```

5. Restrict the user from modifying ~/.bashrc
```sh
chattr +i /home/<username>/.bashrc
```

6. Restrict the user from modifying ~/.bash_history

```sh
chattr +a /home/<username>/.bash_history
```

