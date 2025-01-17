{ pkgs, inputs, ... }:
{
    environment.systemPackages = with pkgs; [
        inputs.ags.packages.x86_64-linux.default
        inputs.astal.packages.${system}.default
        inputs.astal_widget_config.packages.x86_64-linux.run_astal_widgets
        gtk3
        lua
        # gtk4
    ];
}
