import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserHelper {
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static saveUser(User? user, String? role) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userMap = {
      'uid': user!.uid,
      'email': user.email,
      'name': user.displayName,
      'last_login': user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      'buildNumber': buildNumber,
      'created_at': user.metadata.creationTime!.millisecondsSinceEpoch,
      'role': role ?? 'unknown',
    };
    final userRef = _firebaseFirestore.collection('users').doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        'last_login': user.metadata.lastSignInTime!.microsecondsSinceEpoch,
        'buildNumber': buildNumber,
      });
    } else {
      await userRef.set(userMap);
    }
    await _saveDevice(user);
  }

  static _saveDevice(User user) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String? deviceId;
    late Map<String, dynamic> deviceMap;

    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceId = deviceInfo.id;
      deviceMap = {
        'os_version': deviceInfo.version.sdkInt.toString(),
        'platfrom': 'Android',
        'model': deviceInfo.model,
        'device': deviceInfo.device,
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceMap = {
        'os_version': deviceInfo.systemVersion,
        'platfrom': 'ios',
        'model': deviceInfo.model,
        'device': deviceInfo.name,
      };
    }
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final deviceRef = _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .doc(deviceId ?? 'unknown');

    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        'updated_at': nowMs,
        'unistalled': false,
      });
    } else {
      await deviceRef.set({
        'device_info': deviceMap,
        'created_at': nowMs,
        'updated_at': nowMs,
        'unistalled': false,
        'id': deviceId,
      });
    }
  }
}
