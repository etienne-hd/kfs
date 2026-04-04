project('myos', 'c',
  version : '0.1',
  default_options : [
    'c_std=gnu99',
    'optimization=2',
    'warning_level=2'
  ]
)

# On ajoute les flags spécifiques au freestanding
add_project_arguments([
  '-ffreestanding',
], language : 'c')

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

# Définition du noyau
executable('myos.bin',
  'kernel.c',
  'boot.s', # Meson reconnaît l'extension .s
  dependencies: [dep_slib],
  link_args : ['-T', meson.current_source_dir() + '/linker.ld'],
  install : true
)
