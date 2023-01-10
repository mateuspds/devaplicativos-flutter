import 'package:devapp/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/rendering.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  static Future<void> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    getDeviceFirebaseToken();
  }

  static getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('===========================================');
    debugPrint('TOKEN: $token');
    debugPrint('===========================================');
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if(notification != null && android != null){
        _notificationService.showNotification(
          CustomNotification(
              id: android.hashCode,
              title: notification.title!,
              body: notification.body!,
              payload: message.data['route'] ?? '',
          ),
        );
      }
    });
    
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPagaAfterMessage);
  }

  _goToPagaAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if(route.isNotEmpty) {
      //Navega ate a pagina q esta no payload
    }
  }
}