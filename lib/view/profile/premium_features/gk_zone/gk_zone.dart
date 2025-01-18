import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/premium_view_model.dart';
import 'package:provider/provider.dart';

class GkZoneScreen extends StatefulWidget {
  const GkZoneScreen({Key? key}) : super(key: key);

  @override
  State<GkZoneScreen> createState() => _GkZoneScreenState();
}

class _GkZoneScreenState extends State<GkZoneScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gkView = Provider.of<PremiumViewModel>(context, listen: false);
      gkView.gkApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<GkZoneModel> gkList = [
      GkZoneModel(
          title: 'Static Gk',
          ),
      GkZoneModel(
          title: 'Current Affairs')
    ];
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? title = args['title'];
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
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: gkList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.gkPdfScreen,arguments: {'title':gkList[index].title});
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
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                              text:gkList[index].title,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.thirteen,
                              maxLines: 1),
                        ],
                      ),
                      const Spacer(),
                       const Icon(Icons.arrow_forward_ios_sharp)
                    ],
                  )),
                );
              },
            ),
          ],
        ));
  }
}
class GkZoneModel {
  final String title;
  GkZoneModel({
    required this.title,
  });
}