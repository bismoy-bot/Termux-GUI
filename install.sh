#!/data/data/com.termux/files/usr/bin/sh

# Step 1: Install packages
apt update -y && apt upgrade -y 

apt install  x11-repo 
apt install  xfce4 xfce4-goodies termux-x11-nightly code-oss firefox wireshark tigervnc aterm nano tur-repo pulseaudio proot-distro wget git python 

# Step 2: Start and stop VNC to generate initial files
 vncserver :1
 vncserver -kill :1

cat > ~/.vnc/xstartup << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
export DISPLAY=:1
xfce4-session
EOF

# Step 4: Make all scripts executable
chmod +x ~/.vnc/xstartup

# Step 5: Create vncstart
cat > $HOME/vncstart << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
vncserver :1 -geometry 1920x1080
EOF

# Step 6: Create vncstop
cat > $HOME/vncstop << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
vncserver -kill :1
EOF

# Step 7: Make vncstart and vncstop executable
chmod +x $HOME/vncstart $HOME/vncstop

# Step 8: Add to PATH in .bashrc if not already present
grep -qxF 'export PATH=$HOME:$PATH' ~/.bashrc || echo 'export PATH=$HOME:$PATH' >> ~/.bashrc

# Step 9: Reload .bashrc
source ~/.bashrc

echo "Setup completed! Use 'vncstart' to launch and 'vncstop' to stop the session."
