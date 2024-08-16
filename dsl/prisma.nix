{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # prisma-engines # FIX: build fail
    # prismaPackages."@prisma/language-server"
  ];
  environment.variables = {
    # PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
    # PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
    # PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
  };
}
