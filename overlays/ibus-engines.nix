final: prev:

let
  self = prev.ibus-engines;
  mozcdic = final.mozcdic-ut;
in
{
  ibus-engines = self // {
    mozc-ut = final.ibus-engines.mozc.overrideAttrs (previousAttrs: {
      preBuild = previousAttrs.preBuild or "" + ''
        # Add the UT dictionary
        cat ${mozcdic}/mozcdic-ut.txt >> data/dictionary_oss/dictionary00.txt
      '';
    });
  };
}
