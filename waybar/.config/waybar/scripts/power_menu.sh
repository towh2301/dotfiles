#!/bin/bash

chosen=$(echo -e "⏻ Power Off\n🔄 Reboot\n🌙 Suspend\n💾 Hibernate\n❌ Cancel" | rofi -dmenu -theme ~/.config/rofi/themes/powermenu-nightowl.rasi -p "Power Menu")

case "$chosen" in
"⏻ Power Off") systemctl poweroff ;;
"🔄 Reboot") systemctl reboot ;;
"🌙 Suspend") systemctl suspend ;;
"💾 Hibernate") systemctl hibernate ;;
"❌ Cancel") exit 0 ;;
esac
