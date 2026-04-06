sources_slibc = []

subdir('char')
subdir('memory')
subdir('string')
subdir('alloc')

includes_slibc = [include_directories('include', '.')]

lib_slib = static_library('slibc',
  sources_slibc,
  vala_header: 'slibc.h',
  vala_vapi: 'slibc-1.0.vapi',
  include_directories : includes_slibc,
  install : false,
)


dep_slib = declare_dependency(
  link_with : lib_slib,
  include_directories : includes_slibc,
)
