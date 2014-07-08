#!/bin/bash

static_mode () {
	sudo tee /etc/network/interfaces <<-EOF
	auto lo
	iface lo inet loopback

	auto p2p1
	iface p2p1 inet static
	address 192.168.240.96
	netmask 255.255.255.0
	gateway 192.168.240.254
	EOF
}

dhcp_mode () {
	sudo tee /etc/network/interfaces <<-EOF
	auto lo
	iface lo inet loopback

	auto p2p1
	iface p2p1 inet dhcp
	EOF
}

case $1 in
	"static")
		echo "Changing to static IP."
		static_mode
		;;
	"dhcp")
		echo "Changing to DHCP."
		dhcp_mode
		;;
	*)
		echo "Invalid argument."
		exit 2
		;;
esac

echo "Reloading interface..."
sudo ifdown p2p1
sudo ifup p2p1
exit 0
