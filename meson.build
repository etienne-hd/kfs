project('myos', ['c', 'vala', 'nasm'],
  version : '1.0',
  default_options : [
    'c_std=gnu99',
    'optimization=2',
    'warning_level=2' # Wall / Wextra
  ]
)

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir, '--profile=posix'], language: 'vala')

cc = meson.get_compiler('c')

add_project_arguments([
  cc.get_supported_arguments(
    '-ffreestanding',
    '-fno-builtin',
    '-fno-exception',
    '-fno-stack-protector',
    '-fno-rtti',
    '-nostdlib',
    '-nodefaultlibs',
  ),
], language : 'c')

add_project_link_arguments([
  '-ffreestanding',
  '-nostdlib',
  '-lgcc'
], language : 'c')

subdir('lib')
subdir('kernel')


sources = files(
  'boot.s',
  'kernel.vala',
  'kernel/cpu.vapi'
)

executable('kfs.bin',
  sources,
  c_args: '-w',
  dependencies: [dep_kernel, dep_slib],
  link_depends: 'linker.ld',
  link_args : ['-T', meson.current_source_dir() + '/linker.ld'],
  install : true
)
