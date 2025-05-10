#!/data/data/com.termux/files/usr/bin/sh

# Define colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Your custom banner
echo -e "${BLUE}"
cat << "EOF"

 _____                                     _____      _               
|_   _|                                   /  ___|    | |              
  | | ___ _ __ _ __ ___  _   ___  ________\ `--.  ___| |_ _   _ _ __  
  | |/ _ \ '__| '_ ` _ \| | | \ \/ /______|`--. \/ _ \ __| | | | '_ \ 
  | |  __/ |  | | | | | | |_| |>  <       /\__/ /  __/ |_| |_| | |_) |
  \_/\___|_|  |_| |_| |_|\__,_/_/\_\      \____/ \___|\__|\__,_| .__/ 
                                                               | |    
                                                               |_|    
                                                               
EOF

# Colorized message
echo -e "${YELLOW}Created by ${CYAN}Bismoy Ghosh${RESET}"
echo -e "${GREEN}Welcome to Small and powerful World!${RESET}"
echo -e "${RED}This script will Download whole mini computer in your Android!!!${RESET}"

# Wait for 5 seconds
sleep 5

# Step 1: Install packages
apt update -y && apt upgrade -y 
echo -e "${YELLOW}Updateing and Upgrading.Please wait
..${RESET}"
apt install  x11-repo -y
apt install  xfce4 xfce4-goodies termux-x11-nightly code-oss firefox wireshark tigervnc aterm nano tur-repo pulseaudio proot-distro wget git python -y 
echo -e "${YELLOW}Installing Dependencies....${RESET}"
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
