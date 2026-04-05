project('myos', ['c', 'vala'],
  version : '0.1',
  default_options : [
    'c_std=gnu99',
    'optimization=2',
    'warning_level=2'
  ]
)

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

add_project_arguments([
  '-ffreestanding',
], language : 'c')

add_project_link_arguments([
  '-ffreestanding',
  '-nostdlib',
  '-lgcc'
], language : 'c')

subdir('lib')

sources = files(
  'boot.s',
)

subdir('src')

executable('myos.bin',
  sources,
  vala_args: ['--profile=posix'],
  c_args: '-w',
  dependencies: [dep_slib],
  link_depends: 'linker.ld',
  link_args : ['-T', meson.current_source_dir() + '/linker.ld'],
  install : true
)
