#! /bin/bash
printf "Installing required packages, this may take a few minutes.. " >&2
{
sudo useradd -m REMOTE
sudo adduser REMOTE sudo
echo 'REMOTE:0987' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
sudo apt-get install firefox
sudo apt-get install qbittorrent
sudo apt-get install terminator
curl https://rclone.org/install.sh | sudo bash
sudo apt-get install -y leafpad
sudo apt install nautilus nano -y 
sudo adduser REMOTE chrome-remote-desktop
} &> /dev/null &&
printf "\nSetup Complete " >&2 || printf "\nError Occured " >&2
printf '\nGo to https://remotedesktop.google.com/headless and copy the Debian Linux command.\n'
read -p "Paste the copied command Here: " CRP
su - REMOTE -c """$CRP"""
printf 'Go to https://remotedesktop.google.com/access/ and connect to the VM instance. \n\n Upgrading currenct packages to their latest versions..'
if sudo apt-get upgrade &> /dev/null
then {
    sudo service chrome-remote-desktop start &> /dev/null
    printf "\n\nUpgrade Complete." >&2
}
else
    printf "\n\nError Occured." >&2
fi
