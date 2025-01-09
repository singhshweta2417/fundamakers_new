// // ignore_for_file: depend_on_referenced_packages
//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:fundamakers/models/premium_features_model/gk_details_model.dart';
// import 'package:fundamakers/res/app_url.dart';
// import 'package:http/http.dart' as http;
//
//
// class GkDetailsProvider with ChangeNotifier {
//   List<GkDetailsModel> _gkDetailsList = [];
//
//   List<GkDetailsModel> get gkDetailsList => _gkDetailsList;
//
//   void setGkDetailsList(List<GkDetailsModel> gkDetailsCourses) {
//     _gkDetailsList = gkDetailsCourses;
//     notifyListeners();
//   }
//
//   Future<List<GkDetailsModel>> fetchGkDetailsData(String id) async {
//     try {
//       final response = await http.get(
//         Uri.parse('${AppUrls.gkDetailsUrls}$id'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer ${AppUrls.bearerToken}',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final List<dynamic> jsonData = jsonResponse["data"];
//         List<GkDetailsModel> gkDetailsList = jsonData
//             .map((jsonMap) => GkDetailsModel.fromJson(jsonMap))
//             .toList();
//         return gkDetailsList;
//       } else {
//         throw Exception('Failed to load GK details data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching GK details: $e');
//       }
//       throw Exception('Failed to fetch GK details data. Check your internet connection.');
//     }
//   }
// }
//
// // Future<List<GkDetailsModel>> fetchGkDetailsData(String id) async {
// //   try {
// //     final response = await http.get(
// //       Uri.parse('${AppUrls.gkDetailsUrls}$id'),
// //       headers: <String, String>{
// //         'Content-Type': 'application/json; charset=UTF-8',
// //         'Authorization': 'Bearer ${AppUrls.bearerToken}',
// //       },
// //     );
// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> jsonResponse = json.decode(response.body);
// //       final List<dynamic> jsonData = jsonResponse["data"];
// //       List<GkDetailsModel> gkDetailsList = jsonData
// //           .map((jsonMap) => GkDetailsModel.fromJson(jsonMap))
// //           .toList();
// //       return gkDetailsList;
// //     } else {
// //       throw Exception(
// //           'Failed to load subjects data. Status code: ${response.statusCode}');
// //     }
// //   } catch (e) {
// //     if (kDebugMode) {
// //       print(e.toString());
// //     }
// //     throw Exception(
// //         'Failed to fetch subjects data. Check your internet connection.');
// //   }
// // }
