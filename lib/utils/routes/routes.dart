import 'package:flutter/material.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/auth/login_screen.dart';
import 'package:fundamakers/view/auth/otp_screen.dart';
import 'package:fundamakers/view/auth/register_screen.dart';
import 'package:fundamakers/view/bottom_navigation_screen.dart';
import 'package:fundamakers/view/home/course/course_video.dart';
import 'package:fundamakers/view/home/course/menu_course.dart';
import 'package:fundamakers/view/home/notifications.dart';
import 'package:fundamakers/view/home/plans/plan_lists.dart';
import 'package:fundamakers/view/my_course/intro_course_screen.dart';
import 'package:fundamakers/view/my_course/my_course_video_list.dart';
import 'package:fundamakers/view/profile/my_activity/liked_posts.dart';
import 'package:fundamakers/view/profile/online_classes/online_classes_screen.dart';
import 'package:fundamakers/view/profile/online_test_result.dart';
import 'package:fundamakers/view/profile/order_history.dart';
import 'package:fundamakers/view/profile/premium_features/library/b_school_info_screen.dart';
import 'package:fundamakers/view/profile/premium_features/library/class_handouts_subject/class_handouts_screen.dart';
import 'package:fundamakers/view/profile/premium_features/library/class_handouts_subject/class_handouts_subjects.dart';
import 'package:fundamakers/view/profile/premium_features/library/notes_subjects_screen.dart';
import 'package:fundamakers/view/profile/premium_features/library/previous_years_papers.dart';
import 'package:fundamakers/view/profile/user_details_screen.dart';
import 'package:fundamakers/view/splash_screen.dart';
import 'package:fundamakers/view/test/bottom_sheet_test_type.dart';
import 'package:fundamakers/view/test/online_test.dart';
import 'package:fundamakers/view/test/test_list_screen.dart';
import 'package:fundamakers/view/test/sub_list_test_screen.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      case RoutesName.splashScreen:
        return (context) => const SplashScreen();
      case RoutesName.otpScreen:
        return (context) => const OtpScreen();
      case RoutesName.registerScreen:
        return (context) => const RegisterScreen();
      case RoutesName.loginScreen:
        return (context) => const LoginScreen();
      case RoutesName.bottomNavigationBar:
        return (context) => const BottomNavigationPage();
      case RoutesName.userDetailsScreen:
        return (context) => const UserDetailsScreen();
      case RoutesName.notifications:
        return (context) => const Notifications();
      case RoutesName.menuCourse:
        return (context) => const MenuCourse();
      case RoutesName.planCourse:
        return (context) => const PlanCourse();
      case RoutesName.onlineTestResult:
        return (context) => const OnlineTestResult();
      case RoutesName.introCourseScreen:
        return (context) => const IntroCourseScreen();
      case RoutesName.myCourseVideoList:
        return (context) => const MyCourseVideoList();
      case RoutesName.subListMenu:
        return (context) => const SubListTestMenu();
      case RoutesName.mainTestList:
        return (context) => const TestListScreen();
      case RoutesName.testDetailsScreen:
        return (context) => const TestDetailsScreen();
      case RoutesName.orderHistoryScreen:
        return (context) => const OrderHistoryScreen();
      case RoutesName.likedPostScreen:
        return (context) => const LikedPostScreen();
      case RoutesName.classHandOutsScreen:
        return (context) => const ClassHandOutsScreen();
      case RoutesName.onlineTest:
        return (context) => const OnlineTest();
      case RoutesName.courseVideo:
        return (context) => const CourseVideo();
      case RoutesName.onlineClassesList:
        return (context) => const OnlineClassesList();
      case RoutesName.classHandOutsSubjectsScreen:
        return (context) => const ClassHandOutsSubjectsScreen();
      case RoutesName.previousYearsPaperScreen:
        return (context) => const PreviousYearsPaperScreen();
      case RoutesName.bSchoolInfoScreen:
        return (context) => const BSchoolInfoScreen();
      case RoutesName.notesAndSubjectsScreen:
        return (context) => const NotesAndSubjectsScreen();
      default:
        return (context) => const Scaffold(
              body: Center(
                child: Text(
                  'No Route Found!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            );
    }
  }
}
