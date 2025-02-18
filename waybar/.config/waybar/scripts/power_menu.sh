#!/bin/bash

chosen=$(echo -e "⏻ Power Off\n🔄 Reboot\n🌙 Suspend\n💾 Hibernate\n💾 Logout\n❌ Cancel" | rofi -dmenu -theme ~/.config/rofi/themes/powermenu-nightowl.rasi -p "Power Menu")

case "$chosen" in
"⏻ Power Off") systemctl poweroff ;;
"🔄 Reboot") systemctl reboot ;;
"🌙 Suspend") systemctl suspend ;;
"💾 Hibernate") systemctl hibernate ;;
"💾 Logout") systemctl logout ;;
"❌ Cancel") exit 0 ;;
esac
