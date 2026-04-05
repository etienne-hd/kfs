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

# On ajoute les flags spécifiques au freestanding
add_project_arguments([
  '-ffreestanding',
], language : 'c')

#	$(CC) -T linker.ld -o myos.bin -flto -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc lib/libkernel.a 
add_project_link_arguments([
  '-ffreestanding',
  '-nostdlib',
  '-lgcc'
], language : 'c')

# Inclusion de la bibliothèque dans le sous-dossier lib
subdir('lib')

# Compilation du fichier assembleur boot.s
# Meson peut gérer l'assembleur nativement si on ajoute 'cpp' ou via generator
# boot_o = import('pkgconfig').generate(name: 'boot') # Simplifié :
# boot_obj = executable('boot.o', 'boot.s') # Ou utilisez un custom_target

sources = files(
  'boot.s', # Meson reconnaît l'extension .s
  'kernel.vala',
  'screen.vala',
)

# Définition du noyau
executable('myos.bin',
  sources,
  vala_args: ['--profile=posix'],
  c_args: '-w',
  dependencies: [dep_slib],
  link_depends: 'linker.ld',
  link_args : ['-T', meson.current_source_dir() + '/linker.ld'],
  install : true
)
