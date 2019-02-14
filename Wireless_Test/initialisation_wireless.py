# path to debian image 
path_sys="/home/julien/PFE/debian9.img"
session_name='wireless_network'

InitNemu(session=session_name, workspace='.', hdcopy=False)

# configuration host. 
VHostConf('debian', localtime=None, k='fr', display='sdl', vga='std', enable_kvm=None, cpu='kvm64', m='1024')


# hosts 
VHost('host1', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host1.img')], 
nics=[VNic(), VNic()])

VHost('host2', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host2.img')], 
nics=[VNic(), VNic()])

VHost('host3', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host3.img')], 
nics=[VNic(), VNic()])

VHost('host4', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host4.img')], 
nics=[VNic(), VNic()])

VHost('host5', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host5.img')], 
nics=[VNic(), VNic()])

VHost('host6', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host6.img')], 
nics=[VNic(), VNic()])

#wireless interfaces
VAirWic("h1wic")
VAirWic("h2wic")
VAirWic("h3wic")
VAirWic("h4wic")
VAirWic("h5wic")
VAirWic("h6wic")

SetAirMode("h1wic", "adhoc")
SetAirMode("h2wic", "adhoc")
SetAirMode("h3wic", "adhoc")
SetAirMode("h4wic", "adhoc")
SetAirMode("h5wic", "adhoc")
SetAirMode("h6wic", "adhoc")

#links
Link("host1:0", "h1wic")
Link("host2:0", "h2wic")
Link("host3:0", "h3wic")
Link("host4:0", "h4wic")
Link("host5:0", "h5wic")
Link("host6:0", "h6wic")

Join("h2wic", "h1wic")

Join("h1wic", "h4wic")
Join("h1wic", "h5wic")

Join("h5wic", "h3wic")
Join("h5wic", "h4wic")
Join("h5wic", "h6wic")

# connect to internet, aim to install protocol. 
VSlirp('slirp1', net='192.168.0.0/24')
Link(client='host1:1', core='slirp1')

VSlirp('slirp2', net='192.168.0.0/24')
Link(client='host2:1', core='slirp2')

VSlirp('slirp3', net='192.168.0.0/24')
Link(client='host3:1', core='slirp3')

VSlirp('slirp4', net='192.168.0.0/24')
Link(client='host4:1', core='slirp4')

VSlirp('slirp5', net='192.168.0.0/24')
Link(client='host5:1', core='slirp5')

VSlirp('slirp6', net='192.168.0.0/24')
Link(client='host6:1', core='slirp6')

StartNemu()