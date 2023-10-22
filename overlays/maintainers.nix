final: prev:

let
  stephen-huan = {
    name = "Stephen Huan";
    email = "stephen.huan@cgdct.moe";
    github = "stephen-huan";
    githubId = 20411956;
    keys = [{
      fingerprint = "EA6E 2794 8C7D BF5D 0DF0  85A1 0FBC 2E3B A99D D60E";
    }];
  };
in
{
  lib = prev.lib // {
    maintainers = prev.lib.maintainers // { inherit stephen-huan; };
  };
}
