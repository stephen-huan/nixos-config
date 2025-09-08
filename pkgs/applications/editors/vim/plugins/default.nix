{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit }:

final: prev:
{
  lean-nvim = buildVimPlugin {
    pname = "lean.nvim";
    version = "2025-09-08";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "lean.nvim";
      rev = "6f6de40c5829be7700961e5064820ce40d0a91b7";
      sha256 = "sha256-zXrRdCexYhzteu9RpZIWM9L7SlhxkaFK4T81VE70tSU=";
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
}
