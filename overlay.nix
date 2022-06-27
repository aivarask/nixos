inputs: final: prev:

{
  python3 = prev.python3.override {
    packageOverrides = pythonFinal: pythonSelf: {
      py-hello = final.runCommand "py-hello" { } ''
        ${final.hello}/bin/hello
        # presumably you need python for something here...
        mkdir $out
      '';
    };
  };
}
