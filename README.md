# NixOS_Configuration_Files

These are my NixOS configuration files for myself. It includes NixOS + Niri + Waybar

## Repository Structure

This repository contains a base NixOS configuration that can be easily replicated and modified for various PC/laptop setups. The structure allows for:

- **Host-specific configurations** in `hosts/{hostname}/` directory
- **User-specific Home Manager configurations** in `home/{username}/` directory
- **Hardware-specific configurations** auto-generated in `hosts/{hostname}/hardware-configuration.nix`

## Usage

To use this configuration for a new host:
1. Create a new directory under `hosts/` with your hostname
2. Copy the base configuration from `hosts/legion/` to your new host directory
3. Modify `configuration.nix` for your specific hardware and software needs
4. Update `flake.nix` to include your new host configuration

## Key Files

- `flake.nix`: Main entry point that defines inputs and configurations
- `hosts/legion/configuration.nix`: Main NixOS configuration for the LegionPC
- `home/r3d/home.nix`: Home Manager configuration for user 'r3d'
