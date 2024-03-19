final: prev:

let
  self = prev.mpv;
in
{
  mpv = self.override {
    scripts = with final.mpvScripts; [ mpris ];
  };
}
