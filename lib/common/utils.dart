import 'dart:io';

import 'package:uuid/uuid.dart';

generateUUID() {
  return new Uuid().v4();
}

isPlatformSupport() {
  if (Platform.isAndroid) {
    return true;
  }
  if (Platform.isIOS) {
    return true;
  }
  return false;
}
