# For your convenience 
alias PlistBuddy=/usr/libexec/PlistBuddy

WORKSPACE=CatsAndModules_Arkhypchuk.xcworkspace 
SCHEME="CatApp"
CONFIG=Release
DEST="generic/platform=iOS" 
CURRENT_DIR=$(pwd)
VERSION="v1.0.0"
EXPORT_PATH="${CURRENT_DIR}/Exported_$1"
EXPORT_OPTIONS_PLIST="./exportOptions.plist"
ARCHIVE_PATH="${EXPORT_PATH}/${VERSION}.xcarchive"

# IMPLEMENT: 
# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS
PlistBuddy -c "Set :type $1" "./CatApp/CatApp/Info.plist"

# IMPLEMENT:
# Clean build folder
xcodebuild clean -workspace "${WORKSPACE}" -scheme "${SCHEME}"-configuration "${CONFIG}"

# IMPLEMENT:
# Create archive


xcodebuild archive \
-archivePath "${EXPORT_PATH}/${VERSION}.xcarchive" \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"

# IMPLEMENT:
# Export archive

xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${EXPORT_OPTIONS_PLIST}" # обовʼязково!
