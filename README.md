sandymac's gentoo overlay
=========================

Gentoo Overlay for things I, Sandy McArthur, have taken the time to package.

----------

To add this to your list of overlays, as root, run the following

```
# Download and save this repo xml to /etc/layman/overlays/
curl -o /etc/layman/overlays/sandymac.xml https://raw.githubusercontent.com/sandymac/gentoo-overlay/master/sandymac.xml

# Add my overlay to layman
layman -a sandymac

# Sync sandymac layman overlays
layman -s sandymac

# or sync all layman overlays
layman -S
```

If you don't have layman setup on your machine please read this: https://www.gentoo.org/proj/en/overlays/userguide.xml

----------

This overlay provides ebuilds for the following packages:

* [Plex Media Server](https://plex.tv/downloads): media-tv/plex-media-server - Public released are "stable" (arch) and PlexPass releases are "unstable" (~arch)
* [BitTorrent Sync](http://www.bittorrent.com/sync): net-p2p/bittorrent-sync
