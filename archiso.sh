sudo cp /usr/share/archiso/configs/releng ./archiso/

#copy config

rm work/build._make*

sudo mkarchiso -v -w work -o /tmp/archiso ./
