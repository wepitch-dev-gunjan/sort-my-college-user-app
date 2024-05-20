import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/shared/colors_const.dart';

class AppConst1 {
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorsConst.blackColor,
      textColor: ColorsConst.whiteColor,
      fontSize: 16.0,
    );
  }
}
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 16.0),
// child: Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 19.5, vertical: 15),
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// const Text(
// 'Coming soon',
// style: TextStyle(
// color: Color(0xFF1F0A68),
// fontSize: 20,
// fontFamily: 'Inter',
// fontWeight: FontWeight.w600,
// height: 0,
// ),
// ),
// Container(
// width: 45.51,
// height: 19,
// decoration: ShapeDecoration(
// color: const Color(0xFFB1A0EA),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(99),
// ),
// ),
// child: Center(
// child: Text(
// '${counsellorSessionProvider.details.sessions![index].sessionAvailableSlots}/${counsellorSessionProvider.details.sessions![index].sessionSlots}',
// style: const TextStyle(
// color: Colors.white,
// fontSize: 13,
// fontFamily: 'Inter',
// fontWeight: FontWeight.w500,
// height: 0,
// ),
// ),
// ),
// ),
// ],
// ),
// const SizedBox(
// height: 5,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// selectedSessionDate,
// textAlign: TextAlign.center,
// style: const TextStyle(
// color: Colors.black,
// fontSize: 12,
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// height: 0,
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// const Text(
// '2:00 PM - 03:00 PM',
// style: TextStyle(
// color: Colors.black,
// fontSize: 12,
// fontFamily: 'Inter',
// fontWeight: FontWeight.w400,
// height: 0,
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// Text(
// 'Price - ${counsellorSessionProvider.details.sessions?[index].sessionPrice ?? "0"} /-',
// textAlign: TextAlign.center,
// style: const TextStyle(
// color: Colors.black,
// fontSize: 12,
// fontFamily: 'Inter',
// fontWeight: FontWeight.w500,
// height: 0,
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// GestureDetector(
// onTap: () {
// isExpanded = !isExpanded;
// setState(() {});
// },
// child: const Row(
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// Text(
// 'View Details',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.black,
// fontSize: 12,
// fontFamily: 'Inter',
// fontWeight: FontWeight.w800,
// height: 0,
// ),
// ),
// SizedBox(
// width: 10,
// ),
// Icon(
// Icons.arrow_forward_ios,
// size: 15,
// )
// ],
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// isExpanded
// ? Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("Name : ${widget.name}"),
// const SizedBox(
// height: 5,
// ),
// Text(
// "Slots : ${counsellorSessionProvider.details.sessions?[index].sessionSlots ?? "0"}"),
// const SizedBox(
// height: 5,
// ),
// Text(
// "Duration : ${counsellorSessionProvider.details.sessions?[index].sessionDuration ?? "0"}"),
// const SizedBox(
// height: 5,
// ),
// Text(
// "Session Status : ${counsellorSessionProvider.details.sessions?[index].sessionStatus ?? "N/A"}"),
// ],
// )
//     : const SizedBox()
// ],
// ),
// GestureDetector(
// onTap: () {
// if (counsellorSessionProvider.details.sessions![index].sessionAvailableSlots! > 0) {
// startPgTransaction();
// EasyLoading.show(
// status: "Loading...",
// dismissOnTap: false,
// );
//
// // Simulating a payment response for demonstration purposes.
// // Replace this with the actual logic to check the payment status.
// bool isPaymentSuccessful = true;
//
// if (isPaymentSuccessful) {
// ApiService.sessionBooked(
// counsellorSessionProvider.details.sessions![index].id!,
// ).then((value) {
// if (value["message"] == "Counseling session booked successfully") {
// EasyLoading.showToast(
// value["message"],
// toastPosition: EasyLoadingToastPosition.bottom,
// );
// context
//     .read<CounsellorDetailsProvider>()
//     .fetchCounsellor_session(id: widget.id);
// var date = Jiffy.parse(
// counsellorSessionProvider.details.sessions![index].sessionDate!,
// ).format(
// pattern: "yyyy-M-d",
// );
// context
//     .read<CounsellorDetailsProvider>()
//     .fetchCounsellor_session(
// id: widget.id,
// sessionType: "Group",
// date: date,
// );
// setState(() {});
// } else {
// EasyLoading.showToast(
// value["error"],
// toastPosition: EasyLoadingToastPosition.bottom,
// );
// }
// });
// } else {
// EasyLoading.showToast(
// 'Payment failed. Unable to book the session.',
// toastPosition: EasyLoadingToastPosition.bottom,
// );
// }
// } else {
// EasyLoading.showToast(
// 'Slot is not available',
// toastPosition: EasyLoadingToastPosition.bottom,
// );
// }
// },
// child: Container(
// width: 96,
// height: 38,
// decoration: ShapeDecoration(
// color: counsellorSessionProvider.details.sessions![index].sessionAvailableSlots! > 0
// ? const Color(0xFF1F0A68)
//     : Colors.grey,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10),
// ),
// ),
// child: const Center(
// child: Text(
// 'Book',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white,
// fontSize: 18,
// fontFamily: 'Inter',
// fontWeight: FontWeight.w600,
// height: 0,
// ),
// ),
// ),
// ),
// ),
//
// ],
// ),
// ],
// ),
// ),
// ),
// );
