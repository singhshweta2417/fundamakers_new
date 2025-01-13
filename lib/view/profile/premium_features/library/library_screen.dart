import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/view/profile/premium_features/library/b_school_info_screen.dart';
import 'package:fundamakers/view/profile/premium_features/library/class_handouts_subject/class_handouts_subjects.dart';
import 'package:fundamakers/view/profile/premium_features/library/notes_subjects_screen.dart';
import 'package:fundamakers/view/profile/premium_features/library/previous_years_papers.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<LibraryModel> libraryList = [
    LibraryModel(
        title: 'Class Handouts',
        image: Assets.imagesCommunity,
        screen: const ClassHandOutsSubjectsScreen()),
    LibraryModel(
      title: 'Previous Year Papers',
      image: Assets.imagesCommunity,
      screen: const PreviousYearsPaperScreen(),
    ),
    LibraryModel(
      title: 'B-School Info',
      image: Assets.imagesCommunity,
      screen: const BSchoolInfoScreen(),
    ),
    LibraryModel(
      title: 'Notes and E-Books',
      image: Assets.imagesCommunity,
      screen: const NotesAndSubjectsScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(top: height * 0.03),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: libraryList.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  if (libraryList[index].screen is Widget) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            libraryList[index].screen as Widget,
                      ),
                    );
                  }
                },
                child: listContainer(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 0.07,
                      child: const Image(
                        image: AssetImage(Assets.imagesCommunity),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            libraryList[index].title,
                            style: GoogleFonts.robotoCondensed(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                )));
          },
        ));
  }
}

class LibraryModel {
  final String title;
  final String image;
  final dynamic screen;
  LibraryModel({
    required this.title,
    required this.image,
    required this.screen,
  });
}
