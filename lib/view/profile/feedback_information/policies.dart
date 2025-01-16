import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
      body: Column(
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
          const HtmlWidget(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an "
                "unknown printer took a galley of type and scrambled it to make a type specimen book. "
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              textStyle: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      )
    );
  }
}