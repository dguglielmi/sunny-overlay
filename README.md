sunny-overlay
=============

Sunny-overlay is my personal Gentoo Portage overlay. Maybe it will be useful to others (we can always dream).

How to use this overlay ?
-------------------------

To use this overlay follow those steps

- First you need to install layman

```
# emerge -av app-portage/layman
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

-  Fetch & display a list of all the overlays

```
# layman -L
```

-  Finally add sunny-overlay

```
# layman -a sunny-overlay
```

