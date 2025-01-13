import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/view_model/course_view_model.dart';
import 'package:fundamakers/view_model/online_classes_view_model.dart';
import 'package:fundamakers/view_model/plans_view_model.dart';
import 'package:fundamakers/view_model/premium_view_model.dart';
import 'package:fundamakers/view_model/subject_view_model.dart';
import 'package:fundamakers/view_model/user_view_model.dart';
import 'package:fundamakers/res/app_constant.dart';
import 'package:fundamakers/res/components/network.dart';
import 'package:fundamakers/utils/routes/routes.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/bottom_navigation_screen.dart';
import 'package:fundamakers/view_model/auth_view_model.dart';
import 'package:fundamakers/view_model/test_type_details_view_model.dart';
import 'package:fundamakers/view_model/user_details_view_model.dart';
import 'package:fundamakers/view_model/video_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

late Size mq;
double width = 0.0;
double height = 0.0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NetworkChecker _networkChecker;

  @override
  void initState() {
    super.initState();
    _networkChecker = NetworkChecker();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = kIsWeb ? 1600 : MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => AuthenticationViewModel()),
        ChangeNotifierProvider(create: (context) => CoursesViewModel()),
        ChangeNotifierProvider(create: (context) => PlansViewModel()),
        ChangeNotifierProvider(create: (context) => SubjectViewModel()),
        ChangeNotifierProvider(create: (context) => PremiumViewModel()),
        ChangeNotifierProvider(create: (context) => TestTypeViewModel()),
        ChangeNotifierProvider(create: (context) => UserDetailViewModel()),
        ChangeNotifierProvider(create: (context) => VideoViewModel()),
        ChangeNotifierProvider(create: (context) => OnlineClassesViewModel()),
      ],
      child: Builder(
        builder: (context) {
          if (kIsWeb) {
            width = 1600;
            return MaterialApp(
              builder: (context, child) {
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 1600,
                    ),
                    child: child,
                  ),
                );
              },
              title: AppConstant.appName,
              debugShowCheckedModeBanner: false,
              home: const BottomNavigationPage(),
              // initialRoute: RoutesName.splashScreen,
              // routes: Routers.routes,
            );
          } else {
            return MaterialApp(
              title: AppConstant.appName,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.splashScreen,
              onGenerateRoute: (settings) {
                if (settings.name != null) {
                  return MaterialPageRoute(
                      builder: Routers.generateRoute(settings.name!),
                      settings: settings);
                }
                return null;
              },
              builder: (context, child) {
                return Stack(
                  children: [
                    child!,
                    StreamBuilder<NetworkStatus>(
                      stream: _networkChecker.networkStatusStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final status = snapshot.data;
                          if (status == NetworkStatus.noInternet ||
                              status == NetworkStatus.slowInternet) {
                            return _buildNetworkStatusOverlay(status!);
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNetworkStatusOverlay(NetworkStatus status) {
    String message;
    Color backgroundColor;

    switch (status) {
      case NetworkStatus.noInternet:
        message = 'No internet connection';
        backgroundColor = Colors.redAccent;
        break;
      case NetworkStatus.slowInternet:
        message = 'Internet is slow';
        backgroundColor = Colors.orangeAccent;
        break;
      default:
        message = '';
        backgroundColor = Colors.transparent;
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
