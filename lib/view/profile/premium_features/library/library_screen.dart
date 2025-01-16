import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    List<LibraryModel> libraryList = [
      LibraryModel(
          title: 'Class Handouts',
          image: Assets.imagesCommunity,
          onTap: () {
            Navigator.pushNamed(context, RoutesName.classHandOutsSubjectsScreen,
                arguments: {'title': 'Class Handouts'});
          }),
      LibraryModel(
          title: 'Previous Year Papers',
          image: Assets.imagesCommunity,
          onTap: () {
            Navigator.pushNamed(context, RoutesName.previousYearsPaperScreen,
                arguments: {'title': 'Previous Year Papers'});
          }),
      LibraryModel(
          title: 'B-School Info',
          image: Assets.imagesCommunity,
          onTap: () {
            Navigator.pushNamed(context, RoutesName.bSchoolInfoScreen,
                arguments: {'title': 'B-School Info'});
          }),
      LibraryModel(
          title: 'Notes and E-Books',
          image: Assets.imagesCommunity,
          onTap: () {
            Navigator.pushNamed(context, RoutesName.notesAndSubjectsScreen,
                arguments: {'title': 'Notes and E-Books'});
          }),
    ];
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? title = args['title'];
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
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: height * 0.06,
              width: width * 0.3,
              padding: EdgeInsets.symmetric(horizontal: width * 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textWidget(
                      text: title.toString(),
                      fontSize: Dimensions.eighteen,
                      fontWeight: FontWeight.w600),
                  const Image(
                    image: AssetImage(Assets.imagesArrowPng),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: libraryList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: libraryList[index].onTap,
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
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    )));
              },
            ),
          ],
        ));
  }
}

class LibraryModel {
  final String title;
  final String image;
  final void Function()? onTap;
  LibraryModel({
    required this.title,
    required this.image,
    required this.onTap,
  });
}
