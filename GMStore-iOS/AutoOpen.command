DIR=$(dirname $0)
cd $DIR

pod install
open GMStore-iOS.xcworkspace
exit

