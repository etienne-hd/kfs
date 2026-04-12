project('myos', ['c', 'vala', 'nasm'],
  version : '1.0',
  default_options : [
    'c_std=gnu99',
    'optimization=2',
    'warning_level=2' # Wall / Wextra
  ]
)
prefix = get_option('prefix')

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
  'boot.asm',
  'kernel.vala',
  'kernel/cpu.vapi'
)

kfs_bin = executable('kfs.bin',
  sources,
  c_args: '-w',
  dependencies: [dep_kernel, dep_slib],
  link_depends: 'linker.ld',
  link_args : ['-T', meson.current_source_dir() + '/linker.ld'],
  install : true,
  install_dir : prefix
)

if get_option('make_iso') == true
  find_grub_dir = run_command('sh', '-c', 'find /usr/lib /usr/local/lib $HOME/.local/lib -type d -name "i386-pc" | head -n 1', check: true)
  grub_modules_dir = find_grub_dir.stdout().strip()

  if grub_modules_dir == ''
      error('Could not find GRUB modules directory. Please ensure GRUB is installed and the "i386-pc" directory exists in /usr/lib, /usr/local/lib, or $HOME/.local/lib.')
  endif

  grub_cfg_file = files('grub.cfg')

  custom_target('kfs_iso',
    input : [kfs_bin, grub_cfg_file],
    output : 'kfs.iso',
    console: true,
    command : [
      'sh', '-c',
      '''
      set -e
      mkdir -p build_iso/boot/grub
      
      cp "$1" build_iso/boot/kfs.bin
      cp "$2" build_iso/boot/grub/grub.cfg
      
      grub-mkrescue -d "$3" -o "$4" build_iso
      ''',
      'sh',
      '@INPUT0@',
      '@INPUT1@',
      grub_modules_dir,
      '@OUTPUT@'
    ],
    build_by_default : true,
    install : true,
    install_dir : prefix
  )
endif
