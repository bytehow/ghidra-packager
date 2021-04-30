#!/bin/bash
GHIDRA_DIR="ghidra_9.2.3_PUBLIC"
VERSION="9.2.3"

JAVA_HOME=$(/usr/libexec/java_home -v 11)
SUPPORT_DIR="$GHIDRA_DIR/support"
LS_CPATH="${SUPPORT_DIR}/LaunchSupport.jar"
VMARG_LIST=" $(java -cp "${LS_CPATH}" LaunchSupport "${GHIDRA_DIR}" -vmargs)"

BUILD_DIR=output
RUNTIME_DIR=$BUILD_DIR/runtime

# Clean start
rm -rf $BUILD_DIR
mkdir $BUILD_DIR
# Make runtime
# The module list can probably be trimmed down with trial and error
$JAVA_HOME/bin/jlink --verbose \
  --module-path $JAVA_HOME/jmods \
  --output $RUNTIME_DIR \
  --add-modules java.desktop,java.base,java.management,java.compiler,java.rmi,java.xml,java.datatransfer,java.security.sasl,java.sql.rowset,java.smartcardio,java.security.jgss,java.logging,java.xml.crypto,java.naming,java.prefs,java.net.http,java.instrument,java.scripting
#
#
# Make package
jpackage --type app-image \
  --input $GHIDRA_DIR \
  --dest output \
  --name Ghidra \
  --app-version $VERSION \
  --main-jar Ghidra/Framework/Utility/lib/Utility.jar \
  --main-class ghidra.GhidraLauncher \
  --mac-package-name Ghidra \
  --mac-package-identifier org.ghidra-sre \
  --icon Ghidra.icns \
  --runtime-image $RUNTIME_DIR \
  --verbose

# Overwrite generated config 
cp Ghidra.cfg $BUILD_DIR/Ghidra.app/Contents/app/Ghidra.cfg

# Zip it up
pushd $BUILD_DIR
zip -vr ghidra-$VERSION-macos.zip Ghidra.app/ -x "*.DS_Store"
popd
