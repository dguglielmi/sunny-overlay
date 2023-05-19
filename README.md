# sunny-overlay
Sunny-overlay is my personal Gentoo Portage overlay.

## How to use this overlay ?
You can use this overlay with portage plug-in sync system (see: https://wiki.gentoo.org/wiki/Project:Portage/Sync) or alternatively by using app-portage/layman.

### New portage plug-in sync system (>=sys-apps/portage-2.2.16)

- Add "sunny-overlay" configuration
```
# cat << EOF > /etc/portage/repos.conf/sunny-overlay.conf
[sunny-overlay]
location = /usr/local/portage/overlay/sunny-overlay
sync-type = git
sync-uri = git://github.com/dguglielmi/sunny-overlay.git
auto-sync = yes
masters = gentoo
EOF
```
- Retrieve sunny overlay

```
# emaint sync -r sunny-overlay
```
