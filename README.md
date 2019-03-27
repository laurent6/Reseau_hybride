
# Reseau_Hybride

Hybrid routing protocol for wireless mesh network based on [babeld protocol](https://github.com/jech/babeld).

## Getting start

### Environment

To run the protocol, you can use a physical network environment or you can use [Nemu](https://gitlab.com/v-a/nemu/). 
> Nemu is a distributed virtual network environment which fully runs without any administrative rights. It manages fleet of QEMU VMs in order to build a dynamic virtual topology. It provides self-script (launcher and interpreter) and a python API to create and manage heterogeneous, dynamic, distributed, collaborative and mobile virtual networks. 

To install it, follow this [link](https://gitlab.com/v-a/nemu/wikis/tuto/install/debian).

### Setting up Nemu environment

To set an environment with Nemu, you need an image of Linux distributions (more help [here](https://gitlab.com/v-a/nemu/wikis/tuto/fs/debian)).

After that, you need to create a script which specify the number of hosts and the connection between them. You can find a complete documention on this [link](https://gitlab.com/v-a/nemu/wikis/doc/basics).
You can generate a script which all virtual machine can communicate with wireless link.

	./[`generate_all_join.sh`](Wireless_env/generate_all_join.sh) </path/of/image> <session_name> <nb_host>
	
### Setting hosts

You can automatise the configuration of IP address and Build and installation on hosts with [`install.sh`](Wireless_env/install.sh)


## Build and installation

To build the protocol

	cd babeld
	make


To install the protocol

	make install


To uninstall

	make uninstall


## Usage

To run the protocol, use the `babeld` command with the set of interfaces that it should consider

	 {PATH_TO_PROJECT}/babeld-master/babeld <interface>


You can specify option, all option is specified in [man](babeld-master/babeld.man)

	man {PATH_TO_PROJECT}/babeld-master/babeld.man


## Running the tests

You can run the different tests in the directory [test](babeld-master/Tests/test)

	python3 {PATH_TO_PROJECT}/babeld-master/Tests/test/main.py -h

> To test battery criteria with  -b option, use  nemu -f  initialisation_wireless.py -i ( don't forget change path_sys and session_name in this script )   
> To Performance test  with -p option, use  nemu -f init_all_join.py -i ( init_all_join.py is the script generate by generate_all_join.sh ) 


<h3>  Authors  </h3>
<ul>
<li> Laurent BOUQUIN </li> 
<li> Julien  MASSONNEAU </li>
<li> Virgile CHATELAIN </li>
</ul>
