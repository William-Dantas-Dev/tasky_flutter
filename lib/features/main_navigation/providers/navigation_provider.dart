import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavIndex extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}

final bottomNavIndexProvider = NotifierProvider<BottomNavIndex, int>(
  BottomNavIndex.new,
);
