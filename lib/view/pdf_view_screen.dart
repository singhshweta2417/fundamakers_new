import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PDFViewScreen extends StatefulWidget {
  const PDFViewScreen({Key? key}) : super(key: key);

  @override
  PDFViewScreenState createState() => PDFViewScreenState();
}

class PDFViewScreenState extends State<PDFViewScreen>
    with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String? _localFilePath;

  Future<void> _downloadPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final filename = url.substring(url.lastIndexOf("/") + 1);
        final file = File("${dir.path}/$filename");
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _localFilePath = file.path;
        });
      } else {
        throw Exception('Failed to download PDF');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error downloading PDF: $e';
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null && args.containsKey('urlLink')) {
      final urlLink = args['urlLink'];
      _downloadPdf(urlLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final urlLink = args?['urlLink'];
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
        actions: [
          InkWell(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(urlLink))) {
                await launchUrl(Uri.parse(urlLink));
              } else {
                throw 'Could not launch $urlLink';
              }
            },
            child: SizedBox(
              height: height * 0.07,
              width: width * 0.1,
              child: const Icon(Icons.download,
                  size: 30, color: AppColors.textButtonColor),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: _localFilePath != null
                ? PDFView(
                    filePath: _localFilePath!,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: true,
                    pageFling: false,
                    pageSnap: true,
                    defaultPage: currentPage!,
                    fitPolicy: FitPolicy.BOTH,
                    // preventLinkNavigation: false,
                    backgroundColor: Colors.white,
                    onRender: (pages) {
                      setState(() {
                        this.pages = pages;
                        isReady = true;
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    },
                    onPageError: (page, error) {
                      setState(() {
                        errorMessage = '$page: ${error.toString()}';
                      });
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onLinkHandler: (String? uri) {
                      if (kDebugMode) {
                        print('goto uri: $uri');
                      }
                    },
                    onPageChanged: (int? page, int? total) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Container()
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}
