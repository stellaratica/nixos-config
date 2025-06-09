#!/usr/bin/env bash

model=$(awk -F ': ' '/model name/{print $2}' /proc/cpuinfo | head -n 1 | sed 's/@.*//; s/ *\((R)\|(TM)\)//g; s/^[ \t]*//; s/[ \t]*$//')

# Get CPU clock speeds
get_cpu_frequency() {
  freqlist=$(awk '/cpu MHz/ {print $4}' /proc/cpuinfo)
  maxfreq=$(sed 's/...$//' /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)
  average_freq=$(echo "$freqlist" | tr ' ' '\n' | awk "{sum+=\$1} END {printf \"%.0f/%s MHz\", sum/NR, $maxfreq}")
  echo "$average_freq"
}

# Get CPU temperature
get_cpu_temperature() {
  temp=$(sensors | awk '/Package id 0/ {print $4}' | awk -F '[+.]' '{print $2}')
  if [[ -z "$temp" ]]; then
    temp=$(sensors | awk '/Tctl/ {print $2}' | tr -d '+°C')
  fi
  if [[ -z "$temp" ]]; then
    temp="N/A"
  else
    temp_f=$(awk "BEGIN {printf \"%.1f\", ($temp * 9 / 5) + 32}")
  fi
  echo "${temp:-N/A} ${temp_f:-N/A}"
}

# Get corresponding color for temperature
get_temperature_color() {
  temp_value=$1
  if [ "$temp_value" -ge 90 ]; then
    color="#f38ba8" # red
  elif [ "$temp_value" -ge 85 ]; then
    color="#eba0ac" # maroon
  elif [ "$temp_value" -ge 80 ]; then
    color="#fab387" # peach
  elif [ "$temp_value" -ge 70 ]; then
    color="#f9e2af" # yellow
  elif [ "$temp_value" -lt 40 ]; then
    color="#89b4fa" # blue
  elif [ "$temp_value" -lt 50 ]; then
    color="#74c7ec" # sapphire
  elif [ "$temp_value" -lt 60 ]; then
    color="#89dceb" # sky
  fi
  echo "$color"
}

# Get the corresponding icon based on temperature
get_temperature_icon() {
  temp_value=$1
  if [ "$temp_value" -ge 90 ]; then
    icon="" # Critical temperature
  elif [ "$temp_value" -ge 80 ]; then
    icon="" # High temperature
  elif [ "$temp_value" -ge 70 ]; then
    icon="" # Medium temperature
  elif [ "$temp_value" -ge 60 ]; then
    icon="" # Low temperature
  else
    icon="" # Cool as a cucumber
  fi
  echo "$icon"
}

# Main script execution
cpu_frequency=$(get_cpu_frequency)
read -r temp_info < <(get_cpu_temperature)
temp=$(echo "$temp_info" | awk '{print $1}')   # Celsius
temp_f=$(echo "$temp_info" | awk '{print $2}') # Fahrenheit
temp_int=$(echo "$temp" | awk '{$0=int($0)}1') # Temp as an integer

# Determine the temperature icon
thermo_icon=$(get_temperature_icon "$temp_int")

# Set color based on temperature
if { [ "$temp_int" -ge 70 ] || [ "$temp_int" -lt 60 ]; } then
  # If temperature isn't 60-69%, set fancy color
  text_output="<span color='$(get_temperature_color "$temp_int")'>${thermo_icon} ${temp}°C</span>"
else
  # Default color (60-69%)
  text_output="${thermo_icon} ${temp}°C"
fi

tooltip="${model}\n"
tooltip+="Clock Speed: ${cpu_frequency}\nTemperature: ${temp_f}°F"

# Module and tooltip
echo "{\"text\": \"$text_output\", \"tooltip\": \"$tooltip\"}"
