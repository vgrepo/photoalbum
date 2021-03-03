
#!/bin/bash
#this is a comment-the first line sets bash as the shell script
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
rm -rf ./.idea
rm -rf ./android/.gradle
rm -rf ./build
rm ./android/local.properties
rm ./android/gradlew
rm ./android/gradlew.bat
rm ./android/*.iml
rm ./android/gradle/wrapper/gradle-wrapper.jar
rm ./android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java
rm -rf ./ios/Flutter/App.framework
rm -rf ./ios/Flutter/Flutter.framework
rm -rf ./ios/Flutter/Generated.xcconfig
rm -rf ./ios/ServiceDefinitions.json
rm ./ios/Flutter/Generated.xcconfig
rm ./ios/Runner/GeneratedPluginRegistrant.h
rm ./ios/Runner/GeneratedPluginRegistrant.m
rm ./*.iml
rm ./.flutter-plugins
rm ./.packages

echo  "***********************************************"
echo  "*            OBRISATI RUCNO                   *"
echo  "*                                             * "  
echo  "*  .flutter-plugins                           *"
echo  "*  .packages                                  *"
echo  "***********************************************"
flutter pub get
