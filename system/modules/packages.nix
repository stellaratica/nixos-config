{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core tools
    fastfetch
    neovim
    git

    # archives
    zip
    xz
    zstd
    unzipNLS
    p7zip

    # text processing
    gnugrep
    gnused
    gawk

    # networking tools
    wget
    curl
    nmap
    ipcalc
    iw

    # system call monitoring stuff
    strace # classic; for syscalls
    ltrace # also a classic; for library calls
    tcpdump # wireshark's ancestor
    lsof # lists open files, how cool is that

    # system monitoring
    sysstat
    iotop
    iftop
    btop
    nmon
    sysbench

    # system tools
    lm_sensors # for the essential `sensors` command
    pciutils # lspci
    usbutils # lsusb
    dmidecode # cool tool that gets info about the system hardware from the BIOS
    parted

    # misc
    file
    findutils
    which
    tree
    gnutar
    openssl
    pkg-config
    rsync
  ];
}
