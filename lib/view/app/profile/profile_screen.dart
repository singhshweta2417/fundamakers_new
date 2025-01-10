import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/exit_pop_up.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/app/profile/feedback_information/policies.dart';
import 'package:fundamakers/view_model/user_details_view_model.dart';
import 'package:fundamakers/view_model/user_view_model.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/view/app/auth/login_screen.dart';
import 'package:fundamakers/view/app/profile/my_activity/liked_posts.dart';
import 'package:fundamakers/view/app/profile/online_test_result.dart';
import 'package:fundamakers/view/app/profile/order_history.dart';
import 'package:fundamakers/view/app/profile/premium_features/gk_zone/gk_zone.dart';
import 'package:fundamakers/view/app/profile/premium_features/library/library_screen.dart';
import 'package:fundamakers/view/app/profile/premium_features/practice_book/practice_book.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewProfile =
      Provider.of<UserDetailViewModel>(context, listen: false);
      viewProfile.getUserDetailsApi(context);
      setData();
    });
  }

  setData() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final viewProfile =
      Provider.of<UserDetailViewModel>(context, listen: false);
      viewProfile.getUserDetailsApi(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final viewProfile =
    Provider.of<UserDetailViewModel>(context).userDetailsResponse?.data;
    final List<ItemsModel> itemList = [
      ItemsModel(
        title: 'Online Test Result',
        imageData: "",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OnlineTestResult()));
        },
      ),
      ItemsModel(
        title: 'Order History',
        imageData: "",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OrderHistoryScreen()));
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.themeGreenColor,
        title: SizedBox(
          width: width * 0.4,
          child: const Image(
            image: AssetImage(Assets.logoFundamakers),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Text('  Hey! ${viewProfile!=null?viewProfile.firstName:''}',
                style: GoogleFonts.robotoCondensed(
                  textStyle: const TextStyle(
                      color: AppColors.textButtonColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(height: height * 0.01),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: kIsWeb ? 8 : 4.5,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: itemList.map((data) {
                return InkWell(
                  onTap: data.onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    alignment: Alignment.center,
                    child: Text(data.title,
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )),
                  ),
                );
              }).toList(),
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('Account Setting',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(
                        color: AppColors.textButtonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.userDetailsScreen);
              },
              leading: const ImageIcon(
                AssetImage(Assets.imagesProfile),
                color: AppColors.themeGreenColor,
              ),
              title: Text('Edit Profile',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(
                        color: AppColors.textButtonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('My Activity',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(
                        color: AppColors.textButtonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesReviews),
                color: AppColors.themeGreenColor,
                size: 22,
              ),
              title: Text('Liked Posts',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LikedPostScreen()));
              },
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('Premium Features',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(
                        color: AppColors.textButtonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesBook),
                color: AppColors.themeGreenColor,
                size: 22,
              ),
              title: Text('Practice Book',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PracticeBookScreen()));
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesGk),
                color: AppColors.themeGreenColor,
                size: 22,
              ),
              title: Text('GK Zone',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GkZoneScreen()));
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesLibrary),
                color: AppColors.themeGreenColor,
                size: 22,
              ),
              title: Text('Library',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LibraryScreen()));
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesProfileProfession),
                color: AppColors.themeGreenColor,
                size: 22,
              ),
              title: Text('Profile Professor',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {},
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('Feedback & Information',
                  style: GoogleFonts.robotoCondensed(
                    textStyle: const TextStyle(
                        color: AppColors.textButtonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesTermsIcon),
                color: AppColors.themeGreenColor,
              ),
              title: Text(
                'Terms and Condition',
                style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor)),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PolicyScreen()));
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesPolicy),
                color: AppColors.themeGreenColor,
              ),
              title: Text('Privacy Policy',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PolicyScreen()));
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesRefundPolicy),
                color: AppColors.themeGreenColor,
              ),
              title: Text('Refund Policy',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PolicyScreen()));
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage(Assets.imagesBrowse),
                color: AppColors.themeGreenColor,
              ),
              title: Text('Help!',
                  style: GoogleFonts.robotoCondensed(
                    textStyle:
                        const TextStyle(color: AppColors.textButtonColor),
                  )),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 13,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PolicyScreen()));
              },
            ),
            const SizedBox(height: 30),
            AppBtn(
              loading: isLoading,
              width: width * 0.85,
              title: 'LogOut',
              onTap: () async {
                showBackDialog(
                  message: 'Are You Sure want to logout?',
                  context: context,
                  yes: () {
                    final userPref = Provider.of<UserViewModel>(context, listen: false);
                    userPref.remove();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.loginScreen,
                          (Route<dynamic> route) => false,
                    );
                    HapticFeedback.vibrate();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemsModel {
  final String title;
  final String imageData;
  final VoidCallback onTap;
  ItemsModel(
      {required this.title, required this.imageData, required this.onTap});
}
