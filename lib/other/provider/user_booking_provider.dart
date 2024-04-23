import 'package:flutter/foundation.dart';
import 'package:myapp/model/booking_model.dart';
import 'package:myapp/other/api_service.dart';

class UserBookingProvider extends ChangeNotifier {
  List<BookingModel> userBooking = [];
  bool isLoading = false;

  void fetchUserBookings(
      {required bool past, required bool today, required bool upcoming}) async {
    isLoading = true;
    try {
      var userBookings = await ApiService.getUserBooking(
          today: today, past: past, upcoming: upcoming);
      userBooking = userBookings;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  void fetchUserBookingsAll(
      {required bool past, required bool today, required bool upcoming}) async {
    isLoading = true;
    try {
      var userBookings = await ApiService.getUserBookingAll(
          today: today, past: past, upcoming: upcoming);
      userBooking = userBookings;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
