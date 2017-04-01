#变量
#项目target的名字
TARGET_NAME="XXX"
#打包出来的ipa的名字，大多数都是和target不一样的
APPDISPLAY_NAME="YYYY"
CODE_SIGN="iPhone Distribution: xxx Telematics Co., Ltd" PROVISION="XXX"
#build的工作目录
BUILD_DIR="${WORKSPACE}/build"
#打包出来的ipa目录
IPA_DIR="${WORKSPACE}/ipa"
#环境变量的更改
BUILD_CONFIG="Release"

#自动更新SVN代码  start
svn update

#首先，清除build记录：
xcodebuild clean -workspace $TARGET_NAME.xcworkspace -scheme $TARGET_NAME -configuration $BUILD_CONFIG
#设置build号
#其次，执行build：
xcodebuild -workspace $TARGET_NAME.xcworkspace -scheme $TARGET_NAME -configuration $BUILD_CONFIG build BUILD_DIR=$BUILD_DIR BUILD_ROOT="${WORKSPACE}/buildRoot" CODE_SIGN_IDENTITY="$CODE_SIGN" PROVISIONING_PROFILE_SPECIFIER="$PROVISION"

#创建输出目录
mkdir -p $IPA_DIR
cp -f -r $BUILD_DIR/$BUILD_CONFIG-iphoneos/$TARGET_NAME.app.dSYM $IPA_DIR
#最后，将app打包为ipa：
/usr/bin/xcrun -sdk iphoneos PackageApplication -v $BUILD_DIR/$BUILD_CONFIG-iphoneos/$TARGET_NAME.app -o ${WORKSPACE}/ipa/$APPDISPLAY_NAME.ipa

cd ${WORKSPACE}
open .
