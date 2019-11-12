#! /bin/bash
# -----------------------------------
# 注意：
# protonName：proto协议文件夹地址，一般先拉去最新代码：git pull
# beenestName：mobile项目的根目录。
# -----------------------------------

protonName=E:/go/proto
beenestName=E:/flutter/mobile

protoApiPath=$protonName/api
protoCommonPath=$protonName/common
beenestModelPath=$beenestName/lib/class/common/model
beenestApiPath=$beenestModelPath/api
beenestCommonPath=$beenestModelPath/common

echo "rm -rf $beenestApiPath"
rm -rf $beenestApiPath
echo "cp -r $protoApiPath $beenestModelPath"
cp -r $protoApiPath $beenestModelPath

echo "-rf $beenestCommonPath"
rm -rf $beenestCommonPath
echo "cp -r $protoCommonPath $beenestModelPath"
cp -r $protoCommonPath $beenestModelPath

echo "rm $beenestCommonPath/*.go"
rm $beenestCommonPath/*.go

echo "rm $beenestApiPath/*/*.go"
rm $beenestApiPath/**/*.go

echo "cd $beenestModelPath"
cd $beenestModelPath

# 编译命令
echo 'protoc --proto_path=. --dart_out=. api/auth/*.proto api/channel/*.proto api/connector/*.proto api/general/*.proto common/*.proto'
protoc --proto_path=. --dart_out=. api/auth/*.proto api/channel/*.proto api/connector/*.proto api/general/*.proto common/*.proto

#echo 'protoc -I . --dart_out=. common/*.proto --plugin "pub run protoc_plugin"'
#protoc -I . --dart_out=. common/*.proto --plugin "pub run protoc_plugin"
#echo 'protoc -I . --dart_out=. api/**/*.proto --plugin "pub run protoc_plugin"'
#protoc -I . --dart_out=. api/**/*.proto --plugin "pub run protoc_plugin"