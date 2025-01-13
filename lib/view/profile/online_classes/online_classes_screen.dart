import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/online_classes_view_model.dart';
import 'package:provider/provider.dart';

class OnlineClassesList extends StatefulWidget {
  const OnlineClassesList({Key? key}) : super(key: key);

  @override
  State<OnlineClassesList> createState() => _OnlineClassesListState();
}

class _OnlineClassesListState extends State<OnlineClassesList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final onlineClassesView = Provider.of<OnlineClassesViewModel>(context, listen: false);
      onlineClassesView.onlineClassesApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Consumer<OnlineClassesViewModel>(builder: (context, value, _) {
          switch (value.onlineClassesResponse.success) {
            case Success.LOADING:
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
            case Success.COMPLETED:
              if (value.onlineClassesResponse.data != null &&
                  value.onlineClassesResponse.data!.data != null &&
                  value.onlineClassesResponse.data!.data!.isNotEmpty) {
                final onlineClassesView = value.onlineClassesResponse.data!.data!;
                return ListView.builder(
                  padding: EdgeInsets.only(top: height * 0.03),
                  shrinkWrap: true,
                  itemCount: onlineClassesView.length,
                  itemBuilder: (context, index) {
                    return listContainer(
                        child: ListTile(
                          contentPadding:EdgeInsets.zero,
                            minVerticalPadding:0.0,
                          leading: Container(
                              height: height * 0.1,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all( color: Colors.black.withOpacity(0.2),),
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                  image: AssetImage(Assets.imagesSolution),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.green,
                              )),
                          title: textWidget(
                              text: onlineClassesView[index].title.toString(),
                              fontWeight: FontWeight.w700,
                              fontSize: Dimensions.thirteen),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidget(
                                  text: onlineClassesView[index].faculty.toString(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimensions.twelve,color: AppColors.themeGreenColor),
                              textWidget(
                                  text: '3k views',
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimensions.twelve),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.courseVideo,arguments: {'onlineID':onlineClassesView[index].id});
                            //thumbnailUrl:videos[index].thumbnailUrl
                          },
                        ));
                  },
                );
              } else {
                return noDataAvailable();
              }
          }
        }));
  }
}
