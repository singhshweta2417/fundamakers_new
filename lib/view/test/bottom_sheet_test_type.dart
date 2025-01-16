import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/view_model/test_type_details_view_model.dart';
import 'package:provider/provider.dart';

class TestDetailsScreen extends StatefulWidget {
  final String? testId;
  const TestDetailsScreen({Key? key, this.testId}) : super(key: key);

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final testTypeDetails =
            Provider.of<TestTypeViewModel>(context, listen: false);
        testTypeDetails.testTypeDetailApi(widget.testId, context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestTypeViewModel>(builder: (context, value, _) {
      switch (value.testTypeDetailsResponse.success) {
        case Success.LOADING:
          return Container(
            height: height * 0.3,
            width: width,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        case Success.ERROR:
          return Container(
            height: height * 0.3,
            width: width,
            alignment: Alignment.center,
            child: const Image(image: AssetImage(Assets.imagesNoData)),
          );
        case Success.COMPLETED:
          if (value.testTypeDetailsResponse.data != null &&
              value.testTypeDetailsResponse.data!.data != null) {
            final testDetailsView = value.testTypeDetailsResponse.data!.data!;
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.02),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: width * 0.38),
                      textWidget(
                        text: 'Details',
                        fontSize: Dimensions.twentyFour,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textButtonColor,
                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Image(
                    image: const AssetImage(Assets.imagesArrowPng),
                    width: width * 0.3,
                  ),
                  SizedBox(height: height * 0.02),
                  _buildDetailRow('Test Type:', testDetailsView.name ?? ''),
                  SizedBox(height: height * 0.02),
                  _buildDescriptionRow(
                      'Description:', testDetailsView.description ?? '', width),
                  SizedBox(height: height * 0.02),
                  _buildDetailRow('Total Sections:',
                      testDetailsView.totalSections.toString()),
                  SizedBox(height: height * 0.02),
                  _buildDetailRow('Positive Marking:',
                      testDetailsView.positiveMarkingMcq.toString()),
                  SizedBox(height: height * 0.02),
                  _buildDetailRow('Negative Marking:',
                      testDetailsView.negativeMarkingMcq.toString()),
                ],
              ),
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
    });
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(
          text: title,
          fontSize: Dimensions.eighteen,
          fontWeight: FontWeight.w600,
          color: AppColors.textButtonColor,
        ),
        textWidget(
          text: value,
          fontSize: Dimensions.fifteen,
        ),
      ],
    );
  }

  Widget _buildDescriptionRow(String title, String value, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(
          text: title,
          fontSize: Dimensions.eighteen,
          fontWeight: FontWeight.w600,
          color: AppColors.textButtonColor,
        ),
        SizedBox(
          width: width * 0.65,
          child: textWidget(
            textAlign: TextAlign.start,
            text: value,
            fontSize: Dimensions.fifteen,
          ),
        ),
      ],
    );
  }
}
