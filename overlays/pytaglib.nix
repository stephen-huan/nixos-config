final: prev:

{
  # https://github.com/NixOS/nixpkgs/pull/384003
  python3Packages = prev.python3Packages.overrideScope (_: previous: {
    pytaglib = previous.pytaglib.overridePythonAttrs {
      src = final.fetchFromGitHub {
        owner = "supermihi";
        repo = "pytaglib";
        tag = "v2.1.0";
        hash = "sha256-b3ODsG5rdSJ1Tq/0DARf99gHgWWGaArBFAjqeK3mvsY=";
      };
    };
  });
}
