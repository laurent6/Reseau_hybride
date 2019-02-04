
# path to debian image 
path_sys="/espace/lbouquin/debian8.img"
session_name='network'

InitNemu(session=session_name, workspace='.', hdcopy=False)

# configuration host. 
VHostConf('debian', display='sdl', vga='std', enable_kvm=None, localtime=None, 
k='fr', m='4G', cpu='kvm64')


# hosts 
VHost('host1', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host1.img')], 
nics=[
VNic(hw='0a:0a:0a:00:01:01'),
VNic(hw='0a:0a:0a:00:01:02'),
VNic(hw='0c:0c:0c:00:01:01')])

VHost('host2', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host2.img')], 
nics=[
VNic(hw='0a:0a:0a:00:01:03'),
VNic(hw='0a:0a:0a:00:01:04'), 
VNic(hw='0c:0c:0c:00:01:02')])

VHost('host3', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host3.img')], 
nics=[
VNic(hw='0a:0a:0a:00:01:05'),
VNic(hw='0a:0a:0a:00:01:06'), 
VNic(hw='0c:0c:0c:00:01:03')])

VHost('host4', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host4.img')], 
nics=[
VNic(hw='0a:0a:0a:00:01:07'),
VNic(hw='0a:0a:0a:00:01:08'), 
VNic(hw='0c:0c:0c:00:01:04')])


VHost('host5', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host5.img')], 
nics=[
VNic(hw='0a:0a:0a:00:01:09'),
VNic(hw='0a:0a:0a:00:01:10'),
VNic(hw='0a:0a:0a:00:01:15'),
VNic(hw='0a:0a:0a:00:01:16'),
VNic(hw='0c:0c:0c:00:01:05')])

VHost('host6', conf='debian', hds=[VFs(path_sys, 'cow', 
tag='host6.img')], 
nics=[
VNic(hw='0a:0a:0a:00:01:11'),
VNic(hw='0a:0a:0a:00:01:12'), 
VNic(hw='0c:0c:0c:00:01:06')])


#links
VLine("p1")
Link('host1:0','p1:0')
Link('host2:0','p1:1')


VLine("p2")
Link('host1:1','p2:0')
Link('host5:0','p2:1')

VLine("p3")
Link('host5:1','p3:0')
Link('host4:0','p3:1')


VLine("p4")
Link('host4:1','p4:0')
Link('host3:0','p4:1')

VLine("p5")
Link('host3:1','p5:0')
Link('host5:2','p5:1')

VLine("p6")
Link('host5:3','p6:0')
Link('host6:0','p6:1')




# connect to internet, aim to install protocol. 
VSlirp('slirp1', net='192.168.1.0/24')
Link(client='host1:2', core='slirp1')


VSlirp('slirp2', net='192.168.1.0/24')
Link(client='host2:2', core='slirp2')


VSlirp('slirp3', net='192.168.1.0/24')
Link(client='host3:2', core='slirp3')

VSlirp('slirp4', net='192.168.1.0/24')
Link(client='host4:2', core='slirp4')

VSlirp('slirp5', net='192.168.1.0/24')
Link(client='host5:4', core='slirp5')

VSlirp('slirp6', net='192.168.2.0/24')
Link(client='host6:2', core='slirp6')


