import 'package:flutter/material.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/app/community/post_question/community_post_screen.dart';
import 'package:fundamakers/view/app/home/home_screen.dart';
import 'package:fundamakers/view/app/my_course/my_course.dart';
import 'package:fundamakers/view/app/profile/profile_screen.dart';
import 'package:fundamakers/view/app/test/test_type_list.dart';

class BottomNavigationPage extends StatefulWidget {
  final String? phone;

  const BottomNavigationPage({Key? key, this.phone}) : super(key: key);

  @override
  BottomNavigationPageState createState() => BottomNavigationPageState();
}

class BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is int) {
        setState(() {
          currentPageIndex = args;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: AppColors.themeGreenColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.file_copy),
            icon: Icon(Icons.file_copy_outlined),
            label: 'Test',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Community',
          ),
          NavigationDestination(
            icon: Icon(Icons.import_contacts),
            selectedIcon: Icon(Icons.menu_book),
            // icon: Badge(
            //   label: Text('2'),
            //   child: Icon(Icons.messenger_sharp),
            // ),
            label: 'My Course',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: [
        /// Home page
        const HomeScreen(),

        ///test menu
        const TestTypeMenu(),

        /// Community page
        const CommunityPostScreen(),

        /// Course page
        const MyCourse(),

        ///profile
        const ProfileScreen()
      ][currentPageIndex],
    );
  }
}

class NavigatorService {
  static navigateToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavigationBar, arguments: 0);
  }

  static void navigateToCommunityScreen(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavigationBar, arguments: 1);
  }

  static void navigateToCourseScreen(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavigationBar, arguments: 2);
  }

  static void navigateToProfileScreen(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavigationBar, arguments: 3);
  }
}
