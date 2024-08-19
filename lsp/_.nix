{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tigerbeetle
    # https://www.youtube.com/@tigerbeetledb
    # https://www.youtube.com/watch?v=sC1B3d9C_sI
    # https://github.com/apple/foundationdb/
  ];
}
