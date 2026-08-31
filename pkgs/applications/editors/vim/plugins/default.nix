{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit, fetchpatch2 }:

final: prev:
{
  lean-nvim = buildVimPlugin {
    pname = "lean.nvim";
    version = "2026.4.1-unstable-2026-08-10";
    src = fetchFromGitHub {
      owner = "Julian";
      repo = "lean.nvim";
      rev = "3d8027a96ada0fe43bdd01403e1bd4a09d175448";
      hash = "sha256-goOS7UnwvkTAda/ZWup0iev4bqDCtk5Z8rk+iI6Ydmk=";
    };
    meta.homepage = "https://github.com/Julian/lean.nvim/";
    dependencies = with final; [
      nvim-lspconfig
      plenary-nvim
    ];
  };

  polar-nvim = buildVimPlugin {
    pname = "polar.nvim";
    version = "0-unstable-2025-05-24";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "polar.nvim";
      rev = "6ccccce72763bb0c45d361c2c59e729f24a852aa";
      hash = "sha256-djzJqW+nElJpkAPfjmVJsli+fWd8da0rzdSnB9CcOfY=";
    };
    meta.homepage = "https://github.com/stephen-huan/polar.nvim/";
  };

  vim-cython-syntax = buildVimPlugin {
    pname = "vim-cython-syntax";
    version = "0-unstable-2023-08-02";
    src = fetchFromGitHub {
      owner = "lambdalisue";
      repo = "vim-cython-syntax";
      rev = "17a873c8cc026da4460c1ee1aa12709358db8360";
      hash = "sha256-5Qvpyojn7B784Gpw5XgSgXTMla3POnIA4xHUcdkq6Ks=";
    };
    meta.homepage = "https://github.com/lambdalisue/vim-cython-syntax/";
  };
}
