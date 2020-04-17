#If not stated otherwise in this file or this component's LICENSE
#file the following copyright and licenses apply:
#
#Copyright [2019] [RDK Management]
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#
#
#Copyright (c) 2019, Plume Design Inc. All rights reserved.
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#   1. Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#   3. Neither the name of the Plume Design Inc. nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL Plume Design Inc. BE LIABLE FOR ANY
#DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
#The OSYNC HAL abstracts all hardware / system-level functions of the target
#that are not (yet) included in RDK API. Some of the APIs from this file can
#be a part of RDK (or similar) HAL API in the future.

#!/bin/sh

# TODO: Implement missing options

device_type=`cat /version.txt | grep imagename | cut -d':' -f2 | cut -d'-' -f3`
case "$1" in

	-mo)
		if [ $device_type == "extender" ]; then
			echo "RTROM01-2G-EX"
		else
			echo "RTROM01-2G"
		fi
		;;
	-sn)
		if [ $device_type == "extender" ]; then
			echo "5544332211"
		else
			echo "1122334455"
		fi
		#echo "option $1 is not implemented" ; exit 1  # TODO need to fetch actual serial number
		;;
	-fw)
		echo "rdk-yocto-turris-1"
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-cmac)
		#MAC address of eth1 is used to register device with Plume NOC
		echo $(cat /sys/class/net/eth1/address)
		;;
	-cip)
		if [ $device_type == "extender" ]; then
			echo $(ip addr show br-home | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		else
			echo $(ip addr show brlan0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		fi
		;;
	-cipv6)
		echo ""
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-emac)
		if [ $device_type == "extender" ]; then
			echo $(cat /sys/class/net/br-wan/address)
		else
			echo $(cat /sys/class/net/erouter0/address)
		fi
		;;
	-eip)
		if [ $device_type == "extender" ]; then
			echo $(ip addr show br-wan | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		else
			echo $(ip addr show erouter0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		fi
		;;
	-eipv6)
		echo ""
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-lmac)
		if [ $device_type == "extender" ]; then
			echo $(cat /sys/class/net/br-home/address)
		else
			echo $(cat /sys/class/net/brlan0/address)
		fi
		;;
	-lip)
		if [ $device_type == "extender" ]; then
			echo $(ip addr show br-home | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		else
			echo $(ip addr show brlan0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		fi
		;;
	-lipv6)
		echo ""
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-ms)
		echo "Full"
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-mu)
		echo "ssl:wildfire.plume.tech:443"
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;

	*)
		echo "Usage: deviceinfo.sh [-mo|-sn|-fw|-cmac|-cip|-cipv6|-emac|-eip|-eipv6|-lmac|-lip|-lipv6|-ms|-mu]"
		exit 1
		;;
esac
