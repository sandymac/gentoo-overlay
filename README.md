sandymac's gentoo overlay
=========================

Gentoo Overlay for things I, Sandy McArthur, have taken the time to package.

----------

To add this to your list of overlays, as root, run the following

`# Download and save this repo xml to /etc/layman/overlays/
curl -o /etc/layman/overlays/sandymac.xml https://raw.githubusercontent.com/sandymac/gentoo-overlay/master/sandymac.xml`

`# Add my overlay to layman
layman -a sandymac`

If you don't have layman setup on your machine please read this: https://www.gentoo.org/proj/en/overlays/userguide.xml
