#! /bin/bash
protonName=proto
beenestName=bee_nest
protoApiPath=~/$protonName/api
protoCommonPath=~/$protonName/common
beenestModelPath=~/$beenestName/lib/class/common/model
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

echo "protoc -I . --dart_out=. common/*.proto --plugin ~/.pub-cache/bin/protoc-gen-dart"
protoc -I . --dart_out=. common/*.proto --plugin ~/.pub-cache/bin/protoc-gen-dart 
echo "protoc -I . --dart_out=. api/**/*.proto --plugin ~/.pub-cache/bin/protoc-gen-dart"
protoc -I . --dart_out=. api/**/*.proto --plugin ~/.pub-cache/bin/protoc-gen-dart 