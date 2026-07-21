import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'config/core/global_error_handler.dart';
import 'config/dependency/dependency_injection.dart';
import 'firebase_options.dart';
import 'services/notification/notification_service.dart';
import 'services/storage/storage_services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await NotificationService.init();
    
    FlutterError.onError = (d) => globalError(d.exception, d.stack);
    runApp(const MyApp());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }, (error, stack) => globalError(error, stack));
}

Future<void> init() async {
  try {
    final dI = DependencyInjection();
    dI.dependencies();
    await Future.wait([
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
      LocalStorage.getAllPrefData(),
    ]);
    if (LocalStorage.isLogIn) {
      NotificationService.updateToken();
    }
  } catch (e, stack) {
    globalError(e, stack);
  }
}
