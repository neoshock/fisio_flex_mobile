import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Inicializar el servicio de notificaciones
  Future<void> initialize() async {
    // Solicitar el token de registro de FCM
    String? token = await _messaging.getToken();
    print("FCM Token: $token");

    // Configurar la recepción de mensajes en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // Aquí puedes mostrar la notificación en tu aplicación si lo deseas
      }
    });
  }

  // Método para suscribirse a un tema específico
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  // Método para desuscribirse de un tema específico
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }

  Future<bool> getPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}
