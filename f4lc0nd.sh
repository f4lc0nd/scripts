#!/bin/bash

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[1;34m'; CYAN='\033[0;36m'; NC='\033[0m'

# Banner
print_ascii_banner() {
  toilet -f mono12 -F metal "f4lc0nd"
  echo -e "---------------------------------------------------------------"
  echo -e "\033[1;32m      Multi-Category Tool Installer 🚀🐧\033[0m"
   echo -e "---------------------------------------------------------------"
}

# OS Detection
detect_os() {
  echo -e "${CYAN}🔍 Detecting operating system...${NC}"
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    BASE_ID=${ID,,}
    [ -n "$ID_LIKE" ] && BASE_ID=${ID_LIKE,,}

    case "$BASE_ID" in
      *debian*|*ubuntu*)
        OS_TYPE="debian"
        PACKAGE_MANAGER="apt"
        ;;
      *arch*|*manjaro*|*cachy*)
        OS_TYPE="arch"
        PACKAGE_MANAGER="pacman"
        ;;
      *fedora*)
        OS_TYPE="fedora"
        PACKAGE_MANAGER="dnf"
        ;;
      *rhel*|*centos*)
        OS_TYPE="rhel"
        PACKAGE_MANAGER="yum"
        ;;
      *)
        echo -e "${RED}❌ Unsupported distribution: $ID${NC}"
        exit 1
        ;;
    esac
    echo -e "${GREEN}✅ Detected OS type: $OS_TYPE${NC}"
    echo -e "${YELLOW}📦 Using package manager: $PACKAGE_MANAGER${NC}"
  else
    echo -e "${RED}❌ /etc/os-release not found.${NC}"
    exit 1
  fi
}

# Tool installer
install_tool() {
  TOOL="$1"
  echo -e "${CYAN}📦 Installing: $TOOL${NC}"
  case "$PACKAGE_MANAGER" in
    apt) sudo apt update && sudo apt install -y "$TOOL" ;;
    pacman) sudo pacman -Sy --noconfirm "$TOOL" ;;
    dnf) sudo dnf install -y "$TOOL" ;;
    yum) sudo yum install -y "$TOOL" ;;
  esac

  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Installed: $TOOL${NC}"
    echo "$(date): $TOOL" >> installed_tools.log
  else
    echo -e "${RED}❌ Failed to install: $TOOL${NC}"
  fi
}

# Category Banner
show_category_banner() {
  CATEGORY="$1"
  clear
  case "$CATEGORY" in
    "Developer")
      echo -e "${BLUE}"
      echo "╔════════════════════════════╗"
      echo "║ 💻 Developer Tools Zone   ║"
      echo "╚════════════════════════════╝"
      ;;
    "Hacking")
      echo -e "${RED}"
      echo "╔════════════════════════════╗"
      echo "║ 🧠 Hacking Tools Zone      ║"
      echo "╚════════════════════════════╝"
      ;;
    "System")
      echo -e "${YELLOW}"
      echo "╔════════════════════════════╗"
      echo "║ ⚙️ System Utilities Zone   ║"
      echo "╚════════════════════════════╝"
      ;;
    "Networking")
      echo -e "${CYAN}"
      echo "╔════════════════════════════╗"
      echo "║ 🌐 Networking Tools Zone   ║"
      echo "╚════════════════════════════╝"
      ;;
    "Linux Power")
      echo -e "${GREEN}"
      echo "╔════════════════════════════╗"
      echo "║ 🐧 Linux Power Tools Zone  ║"
      echo "╚════════════════════════════╝"
      ;;
    "Productivity")
      echo -e "${MAGENTA}"
      echo "╔════════════════════════════╗"
      echo "║ 🎨 Productivity Tools Zone ║"
      echo "╚════════════════════════════╝"
      ;;
    "PenTesting")
      echo -e "${RED}"
      echo "╔════════════════════════════╗"
      echo "║ 🧪 PenTesting Tools Zone   ║"
      echo "╚════════════════════════════╝"
      ;;
  esac
  echo -e "${NC}"
}

# Category Menu
show_category_menu() {
  local tools=("${!1}")
  local name="$2"

  show_category_banner "$name"

  while true; do
    echo -e "${YELLOW}📂 $name Tools${NC}"
    for i in "${!tools[@]}"; do
      echo "$((i+1))) ${tools[$i]}"
    done
    echo "$(( ${#tools[@]} + 1 ))) Install All"
    echo "b) Back to main menu"
    echo -n "👉 Choose tool: "; read -r opt

    if [[ "$opt" == "0" || "$opt" == "b" ]]; then clear; return; fi

    if [[ "$opt" =~ ^[0-9]+$ && "$opt" -ge 1 && "$opt" -le ${#tools[@]} ]]; then
      install_tool "${tools[$((opt-1))]}"
    elif [[ "$opt" -eq $(( ${#tools[@]} + 1 )) ]]; then
      echo -ne "${YELLOW}⚠️  Confirm install all? [y/N]: ${NC}"; read -r confirm
      if [[ "$confirm" =~ ^[Yy]$ ]]; then
        for tool in "${tools[@]}"; do install_tool "$tool"; done
      else
        echo -e "${CYAN}⏭️  Skipped.${NC}"
      fi
    else
      echo -e "${RED}❌ Invalid selection.${NC}"
    fi
  done
}

# ========================
# Define Tool Categories
# ========================
developer_tools=("git" "nodejs" "code" "docker" "yarn")
hacking_tools=("nmap" "wireshark" "burpsuite" "sqlmap")
system_tools=("htop" "neofetch" "curl" "wget")
networking_tools=("traceroute" "tcpdump" "iperf3" "net-tools")
linux_power_tools=("lsof" "strace" "gdb" "tmux")
productivity_tools=("obsidian" "flameshot" "bat" "exa")
pentesting_tools=("john" "hydra" "aircrack-ng" "bettercap")

# ========================
# Main Menu
# ========================
main_menu() {
  while true; do
    echo -e "\n${BLUE}🌐 Categories${NC}"
    echo "1) Developer Tools"
    echo "2) Hacking Tools"
    echo "3) System Utilities"
    echo "4) Networking Tools"
    echo "5) Linux Power Tools"
    echo "6) Productivity Tools"
    echo "7) PenTesting Tools"
    echo "0) Exit"
    echo -n "👉 Your choice: "; read -r choice

    case "$choice" in
      1) show_category_menu developer_tools[@] "Developer" ;;
      2) show_category_menu hacking_tools[@] "Hacking" ;;
      3) show_category_menu system_tools[@] "System" ;;
      4) show_category_menu networking_tools[@] "Networking" ;;
      5) show_category_menu linux_power_tools[@] "Linux Power" ;;
      6) show_category_menu productivity_tools[@] "Productivity" ;;
      7) show_category_menu pentesting_tools[@] "PenTesting" ;;
      0) echo -e "${YELLOW}👋 Goodbye!${NC}"; exit 0 ;;
      *) echo -e "${RED}❌ Invalid selection.${NC}" ;;
    esac
  done
}

# ========================
# Start Script
# ========================
clear
print_ascii_banner
detect_os
main_menu
