{ pkgs, inputs, ... }:
{
    environment.systemPackages = with pkgs; [
        ags
    ];
}
