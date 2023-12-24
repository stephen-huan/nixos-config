{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit }:

final: prev:
{
  # https://github.com/mfussenegger/nvim-lint/issues/495
  nvim-lint = buildVimPlugin {
    pname = "nvim-lint";
    version = "2023-11-29";
    src = fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-lint";
      rev = "6f589cb93560581dc2a3b9693658afe865e5649e";
      sha256 = "sha256-YT1siOydZkeDdAyDkjMgDd/d28J7CzJO5V8RYD5rOH8=";
    };
    meta.homepage = "https://github.com/mfussenegger/nvim-lint/";
  };

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
