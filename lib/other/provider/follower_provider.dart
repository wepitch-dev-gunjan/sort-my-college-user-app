import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowerProvider extends ChangeNotifier {
  bool _isFollowing = false;
  int _followCount = 0;

  bool get isFollowing => _isFollowing;
  int get followCount => _followCount;

  Future<void> toggleFollowState(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      /*if (_isFollowing) {
        await ApiService.Unfollow_councellor(id);
        _followCount--;
      } else {
        await ApiService.Follow_councellor(id);
        _followCount++;
      }*/

      await prefs.setInt('follow_count', _followCount);
      _isFollowing = !_isFollowing;
      notifyListeners();

    } catch (e) {
      print('Error: $e');
    }
  }


  Future<void> loadFollowCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _followCount = prefs.getInt('follow_count') ?? 0;
    notifyListeners();
  }
  Future<void> initialize() async {
    await loadFollowCount();
  }
}
