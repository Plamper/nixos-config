{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs;[
      (hiPrio gcc13)
      cmake
      gnumake
      gdb
      clang
      lldb_9
      bear
      clang-tools # clangd
    ];
  };
}
