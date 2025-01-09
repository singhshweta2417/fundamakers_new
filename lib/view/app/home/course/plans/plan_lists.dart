import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/plans/plan_list_model.dart';
import 'package:fundamakers/providers/plans/plan_list_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/view/app/my_course/my_course_video_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlanCourse extends StatefulWidget {
  String? subCourse;
  PlanCourse({Key? key, required this.subCourse}) : super(key: key);

  @override
  State<PlanCourse> createState() => _PlanCourseState();
}

class _PlanCourseState extends State<PlanCourse> {
  List<PlanListModel> planList = [];
  PlanListProvider planListProvider = PlanListProvider();

  bool isLoading = false;

  Future<void> allPlanListData(String subCourse) async {
    planList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<PlanListModel> reviewsList =
          await planListProvider.fetchPlanListData(subCourse);
      setState(() {
        planList = reviewsList;
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
    allPlanListData(widget.subCourse.toString());
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
          builder: (BuildContext context, BoxConstraints constraints) {
        double containerWidth = constraints.maxWidth;
        double containerHeight = constraints.maxHeight;
        return isLoading && planList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.themeGreenColor,
                ),
              )
            : planList.isEmpty
                ? const Center(
                    child: Text(
                      "No Data Available...",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: planList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyCourseVideoList()));
                          //CourseVideo
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
                                width:
                                    containerWidth * (width > 600 ? 0.2 : 0.3),
                                child: const Image(
                                  image: AssetImage(Assets.imagesCommunity),
                                ),
                              ),
                              SizedBox(
                                width:
                                    containerWidth * (width > 600 ? 0.2 : 0.40),

                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      planList[index].name.toString(),
                                      style: GoogleFonts.robotoCondensed(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      planList[index]
                                          .shortDescription
                                          .toString(),
                                      maxLines: 2,
                                      style: GoogleFonts.robotoCondensed(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          ignoreGestures: false,
                                          initialRating: 5,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: containerWidth *
                                              (width > 600 ? 0.012 : 0.04),
                                          itemBuilder: (context, _) =>
                                              const Icon(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(height: height * 0.03),
                                  // const Center(child: Icon(Icons.arrow_forward_ios)),
                                  SizedBox(height: height * 0.01),
                                  AppBtn(
                                    onTap: () {
                                      Razorpay razorpay = Razorpay();
                                      var options = {
                                        'key': 'rzp_test_1DP5mmOlF5G5ag',
                                        'amount': 100,
                                        'name': 'Acme Corp.',
                                        'description': 'Fine T-Shirt',
                                        'retry': {
                                          'enabled': true,
                                          'max_count': 1
                                        },
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
                                      razorpay.on(
                                          Razorpay.EVENT_PAYMENT_SUCCESS,
                                          handlePaymentSuccessResponse);
                                      razorpay.on(
                                          Razorpay.EVENT_EXTERNAL_WALLET,
                                          handleExternalWalletSelected);
                                      razorpay.open(options);
                                    },
                                    width: width * 0.16,
                                    height: height * 0.035,
                                    title: 'Buy Now',
                                    fontSize: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 7),
                                    child: Text(
                                      '₹${planList[index].amount.toString()}',
                                      style: GoogleFonts.robotoCondensed(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
