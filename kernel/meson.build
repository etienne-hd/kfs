sources_kernel = files(
  'vga.vala',
  'color.vala',
  'cpu.asm',
  'keyboard.vala',
  'assert.vala',
  'profile.vala',
  'serial_print.vala',
  'cpu.vapi',
  'idt.asm',
  'idt.vapi',
  'idt.vala',
)

includes_kernel = include_directories('.')

lib_kernel = static_library('kernel',
  sources_kernel,
  vala_header: 'kernel.h',
  vala_vapi: 'kernel-1.0.vapi',
  c_args: '-w',
  include_directories : includes_kernel,
  dependencies: [dep_slib],
  install : false,
)

dep_kernel = declare_dependency(
  link_with : lib_kernel,
  include_directories : includes_kernel,
)
