import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/providers/auth/login_providers.dart';
import 'package:fundamakers/providers/auth/new_register_provider.dart';
import 'package:fundamakers/providers/auth/otp_provider.dart';
import 'package:fundamakers/providers/auth/otp_screen_new.dart';
import 'package:fundamakers/providers/auth/registeration_provider.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/providers/course/course_provider.dart';
import 'package:fundamakers/providers/course/sub_course_provider.dart';
import 'package:fundamakers/providers/plans/plan_list_provider.dart';
import 'package:fundamakers/providers/premium_features/b_school_info_provider.dart';
import 'package:fundamakers/providers/premium_features/gk_zone_provider.dart';
import 'package:fundamakers/providers/premium_features/library_provider.dart';
import 'package:fundamakers/providers/premium_features/practice_books_provider.dart';
import 'package:fundamakers/providers/premium_features/previous_years_provider.dart';
import 'package:fundamakers/providers/subjects/subject_provider.dart';
import 'package:fundamakers/providers/test/main_test_provider.dart';
import 'package:fundamakers/providers/test/test_list_provider.dart';
import 'package:fundamakers/providers/video_lectures/video_lecture_details_providers.dart';
import 'package:fundamakers/res/app_constant.dart';
import 'package:fundamakers/res/components/network.dart';
import 'package:fundamakers/utils/routes/routes.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/app/bottom_navigation_screen.dart';
import 'package:fundamakers/view_model/test_type_details_view_model.dart';
import 'package:fundamakers/view_model/user_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'providers/video_lectures/video_lecture_list_provider.dart';

void main() {
  runApp(const MyApp());
  setPathUrlStrategy();
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
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => SubCourseProvider()),
        ChangeNotifierProvider(create: (context) => SubjectProvider()),
        ChangeNotifierProvider(create: (context) => TestListProvider()),
        ChangeNotifierProvider(create: (context) => MainTestListProvider()),
        ChangeNotifierProvider(create: (context) => PlanListProvider()),
        ChangeNotifierProvider(create: (context) => GkZoneProvider()),
        ChangeNotifierProvider(create: (context) => VideoLectureProvider()),
        ChangeNotifierProvider(
            create: (context) => VideoLectureDetailsProvider()),
        ChangeNotifierProvider(create: (context) => HanOutsProvider()),
        ChangeNotifierProvider(create: (context) => PreviousYearProvider()),
        ChangeNotifierProvider(create: (context) => BSchoolInfoProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => OtpScreenProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationNewProvider()),
        ChangeNotifierProvider(create: (context) => PracticeBookProvider()),
        ChangeNotifierProvider(create: (context) => TestTypeViewModel()),
        ChangeNotifierProvider(create: (context) => OtpScreenNewProvider()),
        ChangeNotifierProvider(create: (context) => UserDetailViewModel()),
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
              builder: (context, child)  {
                return Stack(
                  children: [
                    child!,
                    StreamBuilder<NetworkStatus>(
                      stream: _networkChecker.networkStatusStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final status = snapshot.data;
                          if (status == NetworkStatus.noInternet || status == NetworkStatus.slowInternet) {
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

    return
      Material(
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
