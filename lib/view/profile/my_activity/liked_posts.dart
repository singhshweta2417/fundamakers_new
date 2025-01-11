import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/components/like_animation.dart';
import 'package:fundamakers/view/community/bottomsheet.dart';
import 'package:fundamakers/view/community/create_poll.dart';
import 'package:fundamakers/view/community/post_screen.dart';

class LikedPostScreen extends StatefulWidget {
  const LikedPostScreen({Key? key}) : super(key: key);

  @override
  State<LikedPostScreen> createState() => _LikedPostScreenState();
}

class _LikedPostScreenState extends State<LikedPostScreen> {
  List<HomeModel> homeList = [
    HomeModel(
      title: 'What about the CAT? Is it Costly?',
      image: Assets.imagesCommunity,
      postImage: Assets.imagesGirlSplash,
    ),
    HomeModel(
      title:
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ',
      image: Assets.imagesCommunity,
      postImage: '',
    ),
  ];
  bool isAnimating = false;

  Map<String, dynamic> poll = {
    'title': 'What is Your Name?',
    'options': [
      {'id': 1, 'title': 'Shweta', 'votes': 0},
      {'id': 2, 'title': 'Tanisha', 'votes': 0},
    ]
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showPopUp(context);
                },
              );
            },
            child: const Text(
              'Create ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.themeWhiteColor,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: homeList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(15),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: height * 0.022,
                          backgroundImage:
                          const AssetImage(Assets.imagesPerson),
                        ),
                        SizedBox(
                          width: width * 0.6,
                          height: height * 0.02,
                          child: const Text(
                            'Saurabh Singh',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    homeList[index].postImage != ''
                        ? Container(
                      height: height * 0.3,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(homeList[index].postImage),
                        ),
                      ),
                    )
                        : Container(),
                    Container(
                      padding: EdgeInsets.only(top: height * 0.01),
                      width: width * 0.82,
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Ques:',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: homeList[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAnimating = !isAnimating;
                                  });
                                },
                                child: isAnimating
                                    ?LikeAnimation(
                                  isAnimating: isAnimating,
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 27,
                                    weight: 0.01,
                                  ),
                                )
                                    : LikeAnimation(
                                  isAnimating: isAnimating,
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 27,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              '1.7k Like',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        const BottomComment(),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(15),
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlutterPolls(
                    pollOptionsWidth: width * 0.75,
                    pollId: '1',
                    onVoted: (PollOption pollOption, int newTotalVotes) async {
                      if (kDebugMode) {
                        print('Voted: ${pollOption.id}');
                      }
                      return true;
                    },
                    pollOptionsSplashColor: Colors.white,
                    votedProgressColor: Colors.grey.withOpacity(0.3),
                    votedBackgroundColor: Colors.grey.withOpacity(0.2),
                    votesTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    votedPercentageTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    votedCheckmark: const Icon(
                      Icons.check_circle,
                      color: Colors.black,
                      size: 15,
                    ),
                    pollTitle: Align(
                      alignment: Alignment.center,
                      child: Text(
                        poll['title'] ?? 'Default Title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    pollOptions: poll['options'].map<PollOption>((option) {
                      return PollOption(
                        id: option['id'].toString(),
                        title: Text(
                          option['title'],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        votes: option['votes'],
                      );
                    }).toList(),
                    metaWidget: Row(
                      children: [
                        SizedBox(width: width * 0.04),
                        const Text(
                          '•',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '2 weeks left',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomeModel {
  final String title;
  final String image;
  final String postImage;
  HomeModel({
    required this.title,
    required this.image,
    required this.postImage,
  });
}

TextEditingController editPopCon = TextEditingController();

Widget showPopUp(context) {
  return AlertDialog(
    title: const Text(
      'What Do You Want?',
      textAlign: TextAlign.center,
    ),
    content: SizedBox(
        height: height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBtn(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostScreen()));
              },
              width: width * 0.32,
              title: 'Create Post',
            ),
            SizedBox(
              width: width * 0.026,
            ),
            AppBtn(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PollScreen()));
              },
              width: width * 0.32,
              title: 'Create Poll',
            ),
          ],
        )),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'))
    ],
  );
}
