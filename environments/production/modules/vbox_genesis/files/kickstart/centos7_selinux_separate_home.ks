lang en_US
keyboard us
text
auth
zerombr
clearpart --all --initlabel
bootloader --location=mbr
cdrom
selinux --enforcing
timezone --utc America/New_York
part /boot --size=1024 --asprimary --fstype=xfs
part pv.01 --size=1 --grow --asprimary
volgroup rootvg pv.01
logvol swap --vgname=rootvg --size=1024 --name=swap
logvol / --vgname=rootvg --size=4096 --name=root
logvol /home --vgname=rootvg --size=1024 --name=home
rootpw --iscrypted '$1$3B9X7jrF$fMRI8ub7LEcFps8y4DZMy1'
shutdown
%packages --nobase
%end
