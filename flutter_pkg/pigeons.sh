# flutter pub run pigeon \
#   --input pigeons/user.dart \
#   --dart_out lib/src/models/user.dart \
#   --experimental_swift_out ../my_flutter/ios/Runner/UserAuthenticationFlutter.swift

flutter pub run pigeon \
  --input pigeons/counter.dart \
  --dart_out lib/src/models/counter.dart \
  --experimental_swift_out ../my_flutter/ios/Runner/Counter.swift

  

  # Orignal
  # flutter pub run pigeon \
  # --input pigeons/message.dart \
  # --dart_out lib/pigeon.dart \
  # --objc_header_out ios/Runner/pigeon.h \
  # --objc_source_out ios/Runner/pigeon.m \
  # --experimental_swift_out ios/Runner/Pigeon.swift \
  # --java_out ./android/app/src/main/java/dev/flutter/pigeon/Pigeon.java \
  # --java_package "dev.flutter.pigeon"