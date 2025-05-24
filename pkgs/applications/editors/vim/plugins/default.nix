{ lib, buildVimPlugin, buildNeovimPlugin, fetchFromGitHub, fetchgit }:

final: prev:
{
  lean-nvim = buildVimPlugin {
    pname = "lean.nvim";
    version = "2025-05-24";
    src = fetchFromGitHub {
      owner = "stephen-huan";
      repo = "lean.nvim";
      rev = "0e92b4d7b29d533cb5e5c99ccbcf5d76923b4f22";
      sha256 = "sha256-iyBzp3XZgX2EI0oEe4VLNFi6n55HKHw5MjPv4ikbmx4=";
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
