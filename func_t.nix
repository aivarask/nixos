let
  f = import ./func.nix;
in
{
  itest = f.i ./c;
  itest_programs = f.i ./config/programs_;
  i_test = f.i_ ./c;
}
