# AGENTS.md

## Core Commands
- `nixos-rebuild switch --flake .#legion`: Build and activate the configuration for the legion host
- `nixos-rebuild test --flake .#legion`: Build the configuration for the legion host but don't activate it
- `nix flake check`: Validate the flake and its dependencies
- `nix flake update`: Update the flake's inputs to their latest versions
- `nix fmt`: Format all Nix files according to the project's formatter (requires treefmt or alejandra to be configured in flake.nix)

## Repository Structure
- `hosts/{hostname}/configuration.nix`: Main NixOS configuration file for a specific host
- `home/{username}/home.nix`: Home Manager configuration for a specific user
- `hosts/{hostname}/hardware-configuration.nix`: Auto-generated hardware configuration file (should not be manually edited)
- `flake.nix`: Main entry point that defines inputs and NixOS configurations

## Code Style Guidelines
- Indentation: Use 2 spaces for indentation, following existing project style
- Conditional Logic: Use `lib.mkIf`, `lib.mkMerge`, and `lib.mkDefault` for clean conditional configuration
- Module Arguments: Use `specialArgs` in `flake.nix` to pass custom inputs (like an `unstable` channel) to NixOS modules
- Package Access: Prefer `pkgs` over `nixpkgs` within module definitions
- Use `nixpkgs.lib` for utility functions and `builtins` for built-in operations
- Follow NixOS and Home Manager documentation best practices
- Variables should use snake_case naming convention
- Comments use `#` prefix
- No type checking (Nix is dynamically typed)
- All configuration files must be valid Nix syntax
- Configuration files should be structured following the flake pattern