self: super: with super.lib;
foldr composeExtensions (_: _: {}) [
  (import ./pkgs)
  (import ./pkgs/aliases.nix)
  (import ./pkgs/development/python-modules)
] self super
