import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/plans_view_model.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlanCourse extends StatefulWidget {
  const PlanCourse({Key? key}) : super(key: key);

  @override
  State<PlanCourse> createState() => _PlanCourseState();
}

class _PlanCourseState extends State<PlanCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('subCourseId')) {
        final courseId = args['subCourseId'];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final plansListView =
              Provider.of<PlansViewModel>(context, listen: false);
          plansListView.plansApi(courseId.toString(), context);
        });
      }
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
      body: Consumer<PlansViewModel>(builder: (context, value, _) {
        switch (value.plansResponse.success) {
          case Success.LOADING:
            return Container(
              height: height * 0.3,
              width: width,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          case Success.ERROR:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.25,
                  width: width,
                  alignment: Alignment.center,
                  child: const Image(image: AssetImage(Assets.imagesNoData)),
                ),
                textWidget(
                    text: 'No Data Available',
                    fontSize: Dimensions.eighteen,
                    color: AppColors.textButtonColor,
                    fontWeight: FontWeight.w500)
              ],
            );
          case Success.COMPLETED:
            if (value.plansResponse.data != null &&
                value.plansResponse.data!.data != null &&
                value.plansResponse.data!.data!.isNotEmpty) {
              final plansListView = value.plansResponse.data!.data!;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: plansListView.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesName.myCourseVideoList);
                      //CourseVideo
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: 20),
                      height: height * 0.15,
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
                            height: height * 0.09,
                            width: width * (width > 600 ? 0.2 : 0.25),
                            child: const Image(
                              image: AssetImage(Assets.imagesCommunity),
                            ),
                          ),
                          SizedBox(
                            width: width * (width > 600 ? 0.2 : 0.40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: plansListView[index].name.toString(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.twelve),
                                textWidget(
                                    text: plansListView[index]
                                        .shortDescription
                                        .toString(),
                                    fontWeight: FontWeight.w300,
                                    fontSize: Dimensions.thirteen),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: false,
                                      initialRating: 5,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize:
                                          width * (width > 600 ? 0.012 : 0.04),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (double value) {
                                        // Update logic if needed
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: height * 0.01),
                              AppBtn(
                                onTap: () {
                                  Razorpay razorpay = Razorpay();
                                  var options = {
                                    'key': 'rzp_test_1DP5mmOlF5G5ag',
                                    'amount': 100,
                                    'name': 'Acme Corp.',
                                    'description': 'Fine T-Shirt',
                                    'retry': {'enabled': true, 'max_count': 1},
                                    'send_sms_hash': true,
                                    'prefill': {
                                      'contact': '8888888888',
                                      'email': 'test@razorpay.com'
                                    },
                                    'external': {
                                      'wallets': ['paytm']
                                    }
                                  };
                                  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                      handlePaymentErrorResponse);
                                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                      handlePaymentSuccessResponse);
                                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                      handleExternalWalletSelected);
                                  razorpay.open(options);
                                },
                                width: width * 0.16,
                                height: height * 0.035,
                                title: 'Buy Now',
                                fontSize: 12,
                              ),
                              textWidget(
                                  text:
                                      '₹${plansListView[index].amount.toString()}',
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimensions.thirteen),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.25,
                    width: width,
                    alignment: Alignment.center,
                    child: const Image(image: AssetImage(Assets.imagesNoData)),
                  ),
                  textWidget(
                      text: 'No Data Available',
                      fontSize: Dimensions.eighteen,
                      color: AppColors.textButtonColor,
                      fontWeight: FontWeight.w500)
                ],
              );
            }
        }
      }),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // Widget continueButton = ElevatedButton(
    //   child: const Text("Continue"),
    //   onPressed: () {},
    // );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
