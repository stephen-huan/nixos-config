{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit }:

final: prev:
{
  ranger-nvim = buildVimPlugin {
    pname = "ranger.nvim";
    version = "2024-02-09";
    src = fetchFromGitHub {
      owner = "kelly-lin";
      repo = "ranger.nvim";
      rev = "d3b032feee6b3b0cf923222f260523e2bd7f3ad3";
      sha256 = "sha256-8vsSMRRfz6Nj0YIpjGdSwg+iq8Qa7yGbhOmDfWLOgB0=";
    };
    meta.homepage = "https://github.com/kelly-lin/ranger.nvim/";
  };

  polar-nvim = buildVimPlugin {
    pname = "polar.nvim";
    version = "2024-06-08";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "polar.nvim";
      rev = "de79dd9d37c6b03e08610863e1b220585cebda3b";
      sha256 = "sha256-PYeOUowJaG3Cm1odHNc5CDobLF4SV4TVLgq/L3Gn78s=";
    };
    meta.homepage = "https://github.com/stephen-huan/polar.nvim/";
  };

  vim-cython-syntax = buildVimPlugin {
    pname = "vim-cython-syntax";
    version = "2023-08-02";
    src = fetchFromGitHub {
      owner = "lambdalisue";
      repo = "vim-cython-syntax";
      rev = "17a873c8cc026da4460c1ee1aa12709358db8360";
      sha256 = "sha256-5Qvpyojn7B784Gpw5XgSgXTMla3POnIA4xHUcdkq6Ks=";
    };
    meta.homepage = "https://github.com/lambdalisue/vim-cython-syntax/";
  };
}
