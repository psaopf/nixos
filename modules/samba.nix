{
  # Enable the Samba service
  services.samba = {
    enable = true;
    openFirewall = true; # Opens the necessary ports (137-139, 445) in the firewall

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "nixos-share";
        "netbios name" = "nixos-share";
        # Use user-level security (default)
        "security" = "user";
        # Allow guest access if you want a password-less share
        "map to guest" = "bad user";
      };

      # Define your share here
      "public" = {
        "path" = "/home/p/Shared"; # The folder you want to share
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes"; # Set to "no" if you want to require a password
        "create mask" = "0664";
        "directory mask" = "0775";
        # Important for phones/windows to write files properly
        "force user" = "p"; # Replace with your actual NixOS username
      };
    };
  };

  # Optional: Helps Windows and macOS discover the share automatically
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}