# sunny-overlay
Sunny-overlay is my personal Gentoo Portage overlay. Maybe it will be useful to others (we can always dream).

## How to use this overlay ?
You can use this overlay with the new portage plug-in sync system (see: https://wiki.gentoo.org/wiki/Project:Portage/Sync) or alternatively using app-portage/layman.

### New portage plug-in sync system (>=sys-apps/portage-2.2.16)

- Add sunny-overlay's configuration
```
# cat << EOF > /etc/portage/repos.conf/sunny-overlay.conf
[sunny-overlay]
location = /usr/local/portage/overlay/sunny-overlay
sync-type = git
sync-uri = git://github.com/dguglielmi/sunny-overlay.git
auto-sync = yes
EOF
```
- Retrieve the overlay

```
# emaint sync -r sunny-overlay
```

### Layman users

- First you need to install layman and source layman configuration from your make.conf

```
# emerge -av app-portage/layman
# echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf
```

- Add sunny-overlay's layman configuration

```
# cat << EOF > /etc/layman/overlays/sunny-overlay.xml
<?xml version="1.0" ?>
<repositories version="1.0">
	<repo priority="50" quality="experimental" status="unofficial">
		<name>sunny-overlay</name>
		<description>My personal Gentoo Portage overlay.</description>
		<homepage>https://github.com/dguglielmi/sunny-overlay</homepage>
		<owner>
			<email>dg@accelance.fr</email>
		</owner>
		<source type="git">git://github.com/dguglielmi/sunny-overlay.git</source>
	</repo>
</repositories>
EOF
```

-  Fetch & display all overlays list

```
# layman -L
```

-  Finally add sunny-overlay

```
# layman -a sunny-overlay
```
