import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/presentation/bottom_bar_navigation/bottom_bar_navigation.dart';
import 'package:elscus/presentation/change_password_screen/change_password_screen.dart';
import 'package:elscus/presentation/elder_screen/add_new_elder_screen.dart';
import 'package:elscus/presentation/elder_screen/elder_screen.dart';
import 'package:elscus/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:elscus/presentation/history_screen/history_screen.dart';
import 'package:elscus/presentation/history_second_screen/history_second_screen.dart';
import 'package:elscus/presentation/notification_screen/notification_screen.dart';
import 'package:elscus/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:elscus/presentation/report_screen/report_screen.dart';
import 'package:elscus/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:elscus/presentation/sign_up_screen/term_commitments_screen.dart';
import 'package:elscus/presentation/wallet_screen/wallet_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'fire_base/login_with_google_nav.dart';
import 'fire_base/provider/google_sign_in_provider.dart';

import 'core/utils/globals.dart' as globals;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

void showFlutterNotificationForgeround(RemoteMessage message) {
  // print(message.data);
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title!,
      notification.body!,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  var box = await Hive.openBox('elsBox');
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  String? token = await FirebaseMessaging.instance.getToken();
  globals.deviceID = token.toString();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _elsBox = Hive.box('elsBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen(showFlutterNotificationForgeround);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          theme: ThemeData(errorColor: ColorConstant.redErrorText),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (context) => (_elsBox.get('isOpened') == null)
                ? const OnboardingScreen()
                : const LoginWithGoogleNav(),
            '/loginWithGoogleNav': (context) => const LoginWithGoogleNav(),
            '/signUpScreen': (context) => const SignupScreen(),
            '/forgotPasswordScreen': (context) => const ForgotPasswordScreen(),
            '/scheduleScreen': (context) =>
                BottomBarNavigation(selectedIndex: 1, isBottomNav: true),
            '/homeScreen': (context) =>
                BottomBarNavigation(selectedIndex: 0, isBottomNav: true),
            '/accountScreen': (context) =>
                BottomBarNavigation(selectedIndex: 4, isBottomNav: true),
            '/elderScreen': (context) => const ElderScreen(),
            '/addNewElderScreen': (context) => const AddNewElderScreen(),
            '/historyScreen': (context) => const HistoryScreen(),
            '/serviceScreen': (context) =>
                BottomBarNavigation(selectedIndex: 1, isBottomNav: true),
            '/changePasswordScreen': (context) => const ChangePasswordScreen(),
            '/walletScreen': (context) => const WalletScreen(),
            '/notificationScreen': (context) => const NotificationScreen(),
            '/historySecondScreen': (context) => const HistorySecondScreen(),
            '/reportScreen': (context) => const ReportScreen(),
          },
        ),
      );
}
