{ lib, buildFishPlugin, fetchFromGitHub }:

buildFishPlugin {
  pname = "fish-command-timer";
  version = "unstable-2022-05-16";

  src = fetchFromGitHub {
    owner = "jichu4n";
    repo = "fish-command-timer";
    rev = "ba68bd0a1d06ea99aadefe5a4f32ff512783d432";
    sha256 = "sha256-Ip677gZlcO8L/xukD7Qoa+C+EcI2kGd+BSOi2CDOzM4=";
  };

  meta = with lib; {
    description = "Fish shell extension for printing execution time";
    homepage = "https://github.com/jichu4n/fish-command-timer";
    license = licenses.asl20;
    maintainers = with maintainers; [ stephen-huan ];
  };
}
