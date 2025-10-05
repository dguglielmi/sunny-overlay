project(
  'totem-video-thumbnailer', 'c',
  version: '1.0',
  license: 'GPL2+ with exception',
  default_options: 'buildtype=debugoptimized',
  meson_version: '>= 0.50.0'
)

totem_prefix = get_option('prefix')
totem_bindir = join_paths(totem_prefix, get_option('bindir'))
totem_datadir = join_paths(totem_prefix, get_option('datadir'))
totem_localedir = join_paths(totem_prefix, get_option('localedir'))

gst_req_version = '>= 1.6.0'
totem_plparser_req_version = '>= 3.10.1'

gio_dep = dependency('gio-2.0', version: '>= 2.43.4')
gdk_pixbuf_dep = dependency('gdk-pixbuf-2.0')
gst_dep = dependency('gstreamer-1.0', version: gst_req_version)
gst_tag_dep = dependency('gstreamer-tag-1.0', version: '>= 0.11.93')
gst_video_dep = dependency('gstreamer-video-1.0')
totem_plparser_dep = dependency('totem-plparser', version: totem_plparser_req_version)

cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required: true)

config_h = configuration_data()
set_defines = [
  ['GETTEXT_PACKAGE', meson.project_name()],
  ['GNOMELOCALEDIR', totem_localedir],
]

foreach define: set_defines
  config_h.set_quoted(define[0], define[1])
endforeach

configure_file(
  output: 'config.h',
  configuration: config_h
)

totem_video_thumbnailer_sources = files(
  'submodules/totem/src/totem-resources.c',
  'submodules/totem/src/totem-video-thumbnailer.c',
  'submodules/totem/src/gst/totem-gst-helpers.c',
  'submodules/totem/src/gst/totem-gst-pixbuf-helpers.c'
)

totem_video_thumbnailer_deps = [
  gio_dep,
  gdk_pixbuf_dep,
  totem_plparser_dep,
  gst_tag_dep,
  gst_video_dep,
  m_dep,
]

executable(
  'totem-video-thumbnailer',
  totem_video_thumbnailer_sources,
  include_directories: [
    include_directories('submodules/totem/src/'),
    include_directories('submodules/totem/src/gst'),
  ],
  dependencies: totem_video_thumbnailer_deps,
  c_args: [
    '-DG_LOG_DOMAIN="TotemVideoThumbnailer"'
  ],
  install: true,
  install_dir: totem_bindir
)

thumbnailer_sh = find_program('submodules/totem/data/thumbnailer.sh')
mime_type_list = files('submodules/totem/data/mime-type-list.txt')

r = run_command([thumbnailer_sh, mime_type_list], check: true)

thumbnailer_conf = configuration_data()
thumbnailer_conf.set('BINDIR', totem_bindir)
thumbnailer_conf.set('MIME_TYPE', r.stdout().strip())

thumbnailer = 'totem.thumbnailer'

configure_file(
  input: 'submodules/totem/data/' + thumbnailer + '.in',
  output: thumbnailer,
  install: true,
  install_dir: join_paths(totem_datadir, 'thumbnailers'),
  configuration: thumbnailer_conf
)
