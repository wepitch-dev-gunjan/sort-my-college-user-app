import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/news/model/news_response.dart';
import 'package:myapp/shared/api_end_point.dart';
import 'package:myapp/shared/string_const.dart';

class NewsApiService {
  final String apiKey = '608162a7221647ee988aae17953ad92f';

  Future<List<NewsArticle>> fetchCollegeNews() async {
    final response = await http.get(
      Uri.parse('${ApiEndPoint.newsUrl}=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['articles'];
      List<NewsArticle> articles =
          data.map((item) => NewsArticle.fromJson(item)).toList();

      return articles;
    } else {
      throw Exception(StringConst.exceptionText);
    }
  }
}
// onTap: () {
// if (counsellorSessionProvider
//     .details
//     .sessions![index]
//     .sessionAvailableSlots! <=
// 0) {
// startPgTransaction(
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .id,
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .sessionDate,
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .sessionPrice);
// } else if (counsellorSessionProvider
//     .details
//     .sessions![index]
//     .sessionAvailableSlots! <=
// counsellorSessionProvider
//     .details
//     .sessions![index]
//     .sessionAvailableSlots!) {
// EasyLoading.show(
// status:
// "Loading...",
// dismissOnTap:
// false);
// ApiService.sessionBooked(
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .id!)
//     .then((value) {
// if (value[
// "message"] ==
// "Counseling session booked successfully") {
// EasyLoading.showToast(
// value[
// "message"],
// toastPosition:
// EasyLoadingToastPosition
//     .bottom);
// context
//     .read<
// CounsellorDetailsProvider>()
//     .fetchCounsellor_session(
// id: widget
//     .id);
// var date = Jiffy.parse(
// counsellorSessionProvider
//     .details
//     .sessions![
// index]
//     .sessionDate!)
//     .format(
// pattern:
// "yyyy-M-d");
// context
//     .read<
// CounsellorDetailsProvider>()
//     .fetchCounsellor_session(
// id: widget
//     .id,
// sessionType:
// "Group",
// date: date);
// setState(() {});
// } else {
// EasyLoading.showToast(
// value["error"],
// toastPosition:
// EasyLoadingToastPosition
//     .bottom);
// }
// });
// } else {
// EasyLoading.showToast(
// 'Slot is not available',
// toastPosition:
// EasyLoadingToastPosition
//     .bottom);
// }
// },
