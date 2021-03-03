@echo off
ECHO Android brisanje
rd /s .\.idea
dir .\.idea
dir ..\android\.gradle
rd /s .\android\.gradle
dir .\android\.gradle

attrib -A -R -H .\android\local.properties
del /s .\android\local.properties

attrib -A -R -H .\android\gradlew
del /s .\android\gradlew

attrib -A -R -H .\android\gradlew.bat
del /s .\android\gradlew.bat

attrib -A -R -H .\android\*.iml
del /s .\android\*.iml

attrib -A -R -H .\android\gradle\wrapper\gradle-wrapper.jar
del /s .\android\gradle\wrapper\gradle-wrapper.jar
attrib -A -R -H .\android\app\src\main\java\io\flutter\plugins\GeneratedPluginRegistrant.java
del /s  .\android\app\src\main\java\io\flutter\plugins\GeneratedPluginRegistrant.java

rd /s .\build
dir .\build

attrib -A -R -H .\*.iml
del /s .\*.iml

ECHO IOS brisanje
del /s .\ios\Flutter\Generated.xcconfig
del /s .\ios\Runner\GeneratedPluginRegistrant.h
del /s .\ios\Runner\GeneratedPluginRegistrant.m

ECHO  ***********************************************
ECHO  *            OBRISATI RUCNO                   *
ECHO  *                                             *   
ECHO  *  .flutter-plugins                           *
ECHO  *  .packages                                  *
ECHO  ***********************************************
PAUSE 

flutter pub get