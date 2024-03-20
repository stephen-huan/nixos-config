{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit }:

final: prev:
{
  ranger-vim = buildVimPlugin {
    pname = "ranger.vim";
    version = "2019-10-30";
    src = fetchFromGitHub {
      owner = "francoiscabrol";
      repo = "ranger.vim";
      rev = "91e82debdf566dfaf47df3aef0a5fd823cedf41c";
      sha256 = "sha256-6ut7u6AwtyYbHLHa2jelf5PkbtlfHvuHfWRL5z1CTUQ=";
    };
    meta.homepage = "https://github.com/francoiscabrol/ranger.vim/";
  };

  polar-nvim = buildVimPlugin {
    pname = "polar.nvim";
    version = "2024-03-20";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "polar.nvim";
      rev = "b21094b674e42d8a6322588948ad29566eef50e0";
      sha256 = "sha256-BayGSbzXQN75DvYsMrJjThHqyTYdf9ubi4wBYLBQN/M=";
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
