
# https://unix.stackexchange.com/questions/359531/installing-hp-printer-driver-for-arch-linux
pacman -S cups hplip

systemctl start cups

hp-setup -i
# find .ppd through cups.service
# copy ppd to /etc/cups/ppd/HP_LaserJet_400_M401d.ppd
# add items in /etc/cupps/printers.conf


# http://localhost:631/printers/



#Print steps
#
#It is important to know how CUPS works if wanting to solve related issues:
#
#    1. An application sends a PDF file to CUPS when 'print' has been selected (in case the application sends another format, it is converted to PDF first).
#    2. CUPS then looks at the printer's PPD file (printer description file) and figures out what filters it needs to use to convert the PDF file to a language that the printer understands (like PJL, PCL, bitmap or native PDF).
#    3. The filter converts the PDF file to a format understood by the printer.
#    4. Then it is sent to the back-end. For example, if the printer is connected to a USB port, it uses the USB back-end.


# GUI:
#system-config-printer
#gtk3-print-backends


########################################
# web (never tried)
########################################
# localhost:631

# add user to sys
gpasswd -a ben sys #defined in /etc/cups/cups-files.conf

