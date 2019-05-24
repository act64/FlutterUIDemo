python3 createModule.py ;
flutter build apk;
python3 createModule.py app;
cp build/app/outputs/aar/app-release.aar flutterNativeMix/FlutterMixApplication/app/libs/app-release.aar;

