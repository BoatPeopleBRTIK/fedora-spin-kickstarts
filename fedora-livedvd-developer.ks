%include fedora-live-base.ks

part / --size 6000

%packages
# Libraries
@development-libs
@gnome-software-development
@java-development

# SCM tools
bazaar
bzr
cogito
cvs2cl
cvsutils
git
mercurial
monotone
quilt

# IDEs
@eclipse
anjuta
anjuta-docs
codeblocks
pida

# General developer tools
@authoring-and-publishing
@development-tools
@editors
@system-tools
@virtualization
ElectricFence
alleyoop
crash
dejagnu
dogtail
elfutils-devel
emacs
emacs-el
expect
frysk-gnome
gconf-editor
gettext-devel
gnuplot
hexedit
inkscape
intltool
lynx
maven2
mutt
scons
sharutils
socat
sox
sysprof
tcp_wrappers-devel
tcsh
texi2html
xchat

# RPM/Fedora-specific tools
@buildsys-build
createrepo
koji
livecd-tools
mock
rpmdevtools
rpmlint

eclipse-demos

# Should we?
#@sql-server
#@mysql
#@ruby
#@web-development
#@x-software-development
# I think this is going to be too big on x86_64
#*-devel
%end

%post
# Enable debuginfo repository (useful for frysk, gdb, etc.)
awk '
BEGIN {
  debuginfo = 0
}
  /^\[.*\]/ {
  if (/debuginfo/) {
    debuginfo = 1
  } else {
    debuginfo = 0
  }
  print
  next
}
  /enabled=0/ && debuginfo {
  print "enabled=1"
  next
}
{
  print
  next
}' < /etc/yum.repos.d/fedora.repo > /etc/yum.repos.d/fedora.repo.tmp
mv /etc/yum.repos.d/fedora.repo{.tmp,}

cat >> /etc/rc.d/init.d/fedora-live << EOF
# Put link to demonstration videos on the desktop
pushd /home/fedora/Desktop
ln -s /usr/share/eclipse-demos-0.0.1 "Eclipse demonstration videos"
popd
EOF
%end
