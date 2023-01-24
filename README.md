# hybrid_flutter_ios
This source code including architecture using native iOS and Flutter.

Design: iOS Native Swift

Logical: Flutter

App flow and Architecture setup:

1. Pass callback to view model from the UIViewController when user interact with controller -> LoginVC -> LoginViewModel

2. Viewmodel to flutter module using method channel -> LoginViewModel.swift -> AppController.Swift -> AppController.dart

3. Perform logic on flutter side and pass required data to native side using method channel to the app view controller -> AppController.dart -> LoginController.dart to AppController.swift

4. Appviewcontroller to specific view model -> AppController.swift to LoginVIewModel

