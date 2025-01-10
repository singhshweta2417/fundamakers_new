import 'package:flutter/material.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/view_model/test_type_details_view_model.dart';
import 'package:provider/provider.dart';

class TestDetailsScreen extends StatefulWidget {
  final int? testId;
   TestDetailsScreen(this.testId, {Key? key}) : super(key: key);

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final testTypeDetails = Provider.of<TestTypeViewModel>(context, listen: false);
      testTypeDetails.testTypeDetailApi(widget.testId, context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TestTypeViewModel>(
        builder: (context, testTypeViewModel, child) {
          final testTypeDetails = testTypeViewModel.testTypeDetailsResponse?.data;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.03,
          ),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: height * 0.02),
              _buildDetailRow('Test Type:', testTypeDetails?.name ?? ''),
              SizedBox(height: height * 0.02),
              _buildDescriptionRow('Description:', testTypeDetails?.description ?? '', width),
              SizedBox(height: height * 0.02),
              _buildDetailRow('Total Sections:', testTypeDetails?.totalSections.toString() ?? ''),
              SizedBox(height: height * 0.02),
              _buildDetailRow('Positive Marking:', testTypeDetails?.positiveMarkingMcq.toString() ?? ''),
              SizedBox(height: height * 0.02),
              _buildDetailRow('Negative Marking:', testTypeDetails?.negativeMarkingMcq.toString() ?? ''),
            ],
          ),
        );
      }
    );
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
