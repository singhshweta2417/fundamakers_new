import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/models/subjects/subject_model.dart';
import 'package:fundamakers/providers/subjects/subject_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/profile/premium_features/library/class_handouts_subject/class_handouts_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesAndSubjectsScreen extends StatefulWidget {
  const NotesAndSubjectsScreen({Key? key}) : super(key: key);

  @override
  State<NotesAndSubjectsScreen> createState() => _NotesAndSubjectsScreenState();
}

class _NotesAndSubjectsScreenState extends State<NotesAndSubjectsScreen> {

  SubjectProvider subjectProvider = SubjectProvider();

  List<SubjectModel> subjectList = [];
  bool isLoading = false;

  Future<void> allSubjectsData() async {
    subjectList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<SubjectModel> reviewsList = await subjectProvider.fetchSubjectData();
      setState(() {
        subjectList = reviewsList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print('Error fetching subjects data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    allSubjectsData();
  }

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
      body: LayoutBuilder(
          builder:  (BuildContext context, BoxConstraints constraints)  {
            double containerWidth = constraints.maxWidth;
            double containerHeight = constraints.maxHeight;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: subjectList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ClassHandOutsScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        horizontal: containerWidth * 0.05, vertical: 20),
                    height: containerHeight * 0.15,
                    decoration: BoxDecoration(
                      color: AppColors.themeWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: containerHeight * 0.09,
                          width: containerWidth * (width > 600 ? 0.2 : 0.3),
                          child: Image(image: subjectList[index].image!=null? AssetImage(subjectList[index].image.toString()): const AssetImage(Assets.imagesCommunity),),
                        ),
                        SizedBox(
                          width: containerWidth * (width > 600 ? 0.2 : 0.45),
                          height: containerHeight * 0.09,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subjectList[index].name.toString(),
                                style: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Text(
                                'Ques: 10/10',
                                style: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Text(
                                subjectList[index].description.toString(),
                                style: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }

}

