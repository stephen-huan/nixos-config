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
    version = "2023-07-22";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "polar.nvim";
      rev = "83be21bb2154a4f17c54689d5338a6f5f9c686c8";
      sha256 = "sha256-wB6t4iWgjWz3vsK1s0VMgOON37V6nrn43tS2IP5J76U=";
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
