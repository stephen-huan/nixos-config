{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit, fetchpatch2 }:

final: prev:
{
  lean-nvim = buildVimPlugin {
    pname = "lean.nvim";
    version = "2026-02-11";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "lean.nvim";
      rev = "2a8847d1e80eef78940ae3e765d7cf1844487214";
      sha256 = "sha256-07tLRRaZPnXBfCikGunDcBoizBABOcKgIos6xBPiY1M=";
    };
    meta.homepage = "https://github.com/stephen-huan/lean.nvim/";
    dependencies = with final; [
      nvim-lspconfig
      plenary-nvim
    ];
  };

  polar-nvim = buildVimPlugin {
    pname = "polar.nvim";
    version = "2025-05-24";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "polar.nvim";
      rev = "6ccccce72763bb0c45d361c2c59e729f24a852aa";
      sha256 = "sha256-djzJqW+nElJpkAPfjmVJsli+fWd8da0rzdSnB9CcOfY=";
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

  VimFStar = buildVimPlugin {
    pname = "VimFStar";
    version = "2024-03-24";
    src = fetchFromGitHub {
      owner = "FStarLang";
      repo = "VimFStar";
      rev = "dedefcfe0041ad5af4afe1ac4230e3404311bfdb";
      sha256 = "sha256-tTAjbBIKBYkYzUmqbMycSvuPEmuLLG8LQL1WVMwzd7c=";
    };
    meta.homepage = "https://github.com/FStarLang/VimFStar/";
  };
}
