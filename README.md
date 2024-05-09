![pkgcheck](https://github.com/dguglielmi/sunny-overlay/actions/workflows/pkgcheck.yaml/badge.svg)

# sunny-overlay
Sunny-overlay is my personal Gentoo Portage overlay.

## How to use this overlay ?
You can use this overlay with portage plug-in sync system (see: https://wiki.gentoo.org/wiki/Project:Portage/Sync)

### New portage plug-in sync system (>=sys-apps/portage-2.2.16)

- Add "sunny-overlay" configuration
```
# cat << EOF > /etc/portage/repos.conf/sunny-overlay.conf
[sunny-overlay]
location = /var/db/repos/sunny-overlay
sync-type = git
sync-uri = https://github.com/dguglielmi/sunny-overlay.git
auto-sync = yes
masters = gentoo
EOF
```

OR via eselect-repository

```
# emerge app-eselect/eselect-repository
# eselect repository add sunny-overlay git https://github.com/dguglielmi/sunny-overlay.git
```

- Retrieve sunny overlay

```
# emaint sync -r sunny-overlay
```
