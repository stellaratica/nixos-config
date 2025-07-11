#!/usr/bin/env bash

# This script gathers detailed Wi-Fi connection information.
# It collects the following fields:
#
# - SSID (Service Set Identifier): The name of the Wi-Fi network you
#   are currently connected to.  Example: "My_Network"
#
# - IP Address: The IP address assigned to the device by the router.
#   This is typically a private IP within the local network.  Example:
#   "192.168.1.29/24" (with subnet mask)
#
# - Router (Gateway): The IP address of the router (default gateway)
#   that your device uses to communicate outside the local network.
#   Example: "192.168.1.1"
#
# - MAC Address: The unique Media Access Control address of the local
#   device's Wi-Fi adapter.  Example: "F8:34:41:07:1B:65"
#
# - Security: The encryption protocol being used to secure your Wi-Fi
#   connection. Common security protocols include:
#   - WPA2 (Wi-Fi Protected Access 2): The most commonly used security
#     standard, offering strong encryption (AES).
#   - WPA3: The latest version, providing even stronger security,
#     especially in public or open networks.
#   - WEP (Wired Equivalent Privacy): An outdated and insecure protocol
#     that should not be used.
#   Example: "WPA2" indicates that the connection is secured using WPA2
#   with AES encryption.
#
# - BSSID (Basic Service Set Identifier): The MAC address of the Wi-Fi
#   access point you are connected to.  Example: "A4:22:49:DA:91:A0"
#
# - Channel: The wireless channel your Wi-Fi network is using. This is
#   associated with the frequency band.  Example: "100 (5500 MHz)"
#   indicates the channel number (100) and the frequency (5500 MHz),
#   which is within the 5 GHz band.
#
# - RSSI (Received Signal Strength Indicator): The strength of the
#   Wi-Fi signal, typically in dBm (decibels relative to 1 milliwatt).
#   Closer to 0 means stronger signal, with values like -40 dBm being
#   very good.  Example: "-40 dBm"
#
# - Signal: The signal quality, which is represented as a percentage,
#   where higher numbers mean better signal.  Example: "100"
#   indicates perfect signal strength.
#
# - Rx Rate (Receive Rate): The maximum data rate (in Mbit/s) at which
#   the device can receive data from the Wi-Fi access point.  Example:
#   "866.7 MBit/s" indicates a high-speed connection on a modern
#   standard.
#
# - Tx Rate (Transmit Rate): The maximum data rate (in Mbit/s) at
#   which the device can send data to the Wi-Fi access point.  Example:
#   "866.7 MBit/s"
#
# - PHY Mode (Physical Layer Mode): The Wi-Fi protocol or standard in
#   use.  Common modes include 802.11n, 802.11ac, and 802.11ax (Wi-Fi
#   6).  Example: "802.11ac" indicates you're using the 5 GHz band with
#   a modern high-speed standard.

if ! command -v nmcli &>/dev/null; then
  echo 󰤫
  exit 1
fi

# Check if Wi-Fi is enabled
wifi_status=$(nmcli radio wifi)

if [ "$wifi_status" = "disabled" ]; then
  echo 󰤮
  exit 0
fi

wifi_info=$(nmcli -t -f active,ssid,signal,security dev wifi | grep "^yes")

# If no ESSID is found, set a default value
if [ -z "$wifi_info" ]; then
  # essid="No Connection"
  signal=0
  # tooltip="No Connection"
else
  # Some defaults
  # ip_address="127.0.0.1"
  # gateway="127.0.0.1"
  # mac_address="N/A"
  # security=$(echo "$wifi_info" | awk -F: '{print $4}')
  # bssid="N/A"
  # chan="N/A"
  # rssi="N/A"
  # rx_bitrate=""
  # tx_bitrate=""
  # phy_mode=""
  signal=$(echo "$wifi_info" | awk -F: '{print $3}')
fi

# Determine Wi-Fi icon based on signal strength
if [ "$signal" -ge 80 ]; then
  icon="󰤨" # Strong signal
elif [ "$signal" -ge 60 ]; then
  icon="󰤥" # Good signal
elif [ "$signal" -ge 40 ]; then
  icon="󰤢" # Weak signal
elif [ "$signal" -ge 20 ]; then
  icon="󰤟" # Very weak signal
else
  icon="󰤯" # No signal
fi

# Module and tooltip
echo "$icon"
