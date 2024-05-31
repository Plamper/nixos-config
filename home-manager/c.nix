{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs;[
      (hiPrio gcc13)
      cmake
      gnumake
      unstable.gdb
      clang
      lldb
      bear
      clang-tools # clangd
      ninja

      # Doxygen stuff
      doxygen
      graphviz
    ];
  };
}
