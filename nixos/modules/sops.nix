# SOPS-Nix configuration for encrypted secrets management

{ inputs, config, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "~/.config/sops/age/keys.txt";
  };

  # Example secrets configuration
  # sops.secrets.example-key = { };
  # sops.secrets."myservice/my_subdir/my_secret" = {
  #   owner = "sometestservice";
  # };

  # Example systemd service using secrets
  # systemd.services."sometestservice" = {
  #   script = ''
  #       echo "
  #       Hey bro! I'm a service, and imma send this secure password:
  #       $(cat ${config.sops.secrets."myservice/my_subdir/my_secret".path})
  #       located in:
  #       ${config.sops.secrets."myservice/my_subdir/my_secret".path}
  #       to database and hack the mainframe
  #       " > /var/lib/sometestservice/testfile
  #     '';
  #   serviceConfig = {
  #     User = "sometestservice";
  #     WorkingDirectory = "/var/lib/sometestservice";
  #   };
  # };

  # Example user for the service
  # users.users.sometestservice = {
  #   home = "/var/lib/sometestservice";
  #   createHome = true;
  #   isSystemUser = true;
  #   group = "sometestservice";
  # };
  # users.groups.sometestservice = { };
}
