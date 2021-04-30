<p align="center">
<img src="https://raw.githubusercontent.com/bytehow/ghidra-packager/master/ghidra-native.gif" height="790">
</p>

# ghidra-packager
Packages Ghidra as a native application with a bundled JRE using [jpackage](https://openjdk.java.net/jeps/392) and [jlink](https://openjdk.java.net/jeps/282).
[Releases](https://github.com/bytehow/ghidra-packager/releases) are available for you to download, but you can also package Ghidra yourself. Currently, only macOS is supported.

# Package
1. Download and unzip a Ghidra release
2. Update `$GHIDRA_DIR` and `$VERSION` in `build_app.sh`
3. Run `build_app.sh`
