# dm-crypt project home page:
https://wiki.archlinux.org/title/Dm-crypt

## follow the instruction
https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition

### LUKS on a partition(Only this section)
#### 1. Prepare the disk
```sh
# Create
cryptsetup luksFormat /dev/sda9 <--key-file=/path/to/keyfile>

# Open
cryptsetup open /dev/sda9 crypthome <--key-file=/path/to/keyfile>

# Close
cryptsetup close /dev/mapper/crypthome

# Add keys
cryptsetup luksAddKey /dev/sda9 </path/to/keyfile>

# Change keys
cryptsetup luksChangeKey /dev/sda9 <--key-file=/path/to/keyfile>

# Remove keys
cryptsetup luksRemoveKey /dev/sda9 <--key-file=/path/to/keyfile>
```


#### 2. Add kernel modules
By means of `/etc/mkinitcpio.conf` [link](https://wiki.archlinux.org/title/Mkinitcpio)

Which hooks to choose, please see 'Common_hooks' section in `mkinitcpio.conf` [link](https://wiki.archlinux.org/title/Mkinitcpio#Common_hooks)

I use systemd, so HOOKS is:
```conf
HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)
```

#### 3. Auto mount at boot
1. root
...

2. other partition
`/etc/crypttab` and `/etc/cryptsetup-keys.d/home-crypt.key/`

```conf
home-crypt    UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx    /etc/cryptsetup-keys.d/home-crypt.key
```


