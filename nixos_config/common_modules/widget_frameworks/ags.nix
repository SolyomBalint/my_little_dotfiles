{ pkgs, inputs, ... }:
{
    environment.systemPackages = with pkgs; [
        inputs.ags.packages.x86_64-linux.default
        inputs.astal.packages.${system}.default
        gtk3
        # gtk4
    ];
}
