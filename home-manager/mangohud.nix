{
  programs.mangohud = {
    enable = true;
    settings = {
      legacy_layout = 0;
      horizontal = true;
      gpu_stats = true;
      cpu_stats = true;
      # cpu_power = true;
      gpu_power = true;
      ram = true;
      fps = true;
      frametime = 0;
      hud_no_margin = true;
      table_columns = 14;
      frame_timing = 1;
      # Broken with mangoapp
      #no_display = true;
      vulkan_driver = true;
      cpu_temp = true;
      gpu_temp = true;
    };
  };
}
