{ config, pkgs, lib, ... }:

let
  jupyterEnv = pkgs.python3.withPackages (ps: with ps; [
    jupyterlab
    ipykernel
    matplotlib
    numpy
    pandas
    scipy
  ]);
in
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "jupyter-lab" ''
      export JUPYTERLAB_DIR="${jupyterEnv}/share/jupyter/lab"
      exec ${jupyterEnv}/bin/python3 -m jupyterlab "$@"
    '')
    jupyterEnv
  ];
}
