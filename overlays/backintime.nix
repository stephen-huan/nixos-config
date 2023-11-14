final: prev:

let
  self = prev.backintime;
  python' = builtins.elemAt self.buildInputs 0;
in
{
  backintime = self.overrideAttrs (previous: {
    preFixup = previous.preFixup + ''
      substituteInPlace "$out/share/polkit-1/actions/net.launchpad.backintime.policy" \
        --replace "/usr/bin/backintime-qt" "$out/bin/backintime-qt"

      substituteInPlace "$out/share/applications/backintime-qt-root.desktop" \
        --replace "/usr/bin/backintime-qt" "backintime-qt"

      substituteInPlace "$out/share/backintime/qt/serviceHelper.py" \
        --replace "'which'" "'${final.which}/bin/which'" \
        --replace "/bin/su" "${final.su}/bin/su" \
        --replace "/usr/bin/backintime" "${final.backintime-common}/bin/backintime" \
        --replace "/usr/bin/nice" "${final.coreutils}/bin/nice" \
        --replace "/usr/bin/ionice" "${final.util-linux}/bin/ionice"

      substituteInPlace "$out/share/dbus-1/system-services/net.launchpad.backintime.serviceHelper.service" \
        --replace "/usr/bin/python3" "${python'}/bin/python3" \
        --replace "/usr/share/backintime" "$out/share/backintime"

      substituteInPlace "$out/bin/backintime-qt_polkit" \
        --replace "/usr/bin/backintime-qt" "$out/bin/backintime-qt"
      wrapProgram "$out/bin/backintime-qt_polkit" \
        --prefix PATH : "${final.polkit}/bin:$PATH"
    '';
  });
}
