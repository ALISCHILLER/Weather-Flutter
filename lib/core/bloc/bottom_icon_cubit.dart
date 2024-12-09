
import 'package:bloc/bloc.dart';



/// تعریف وضعیت‌ها برای Bottom Navigation
enum BottomNavState { home, bookmark }

/// مدیریت وضعیت Bottom Navigation
class BottomIconCubit extends Cubit<BottomNavState> {
  /// مقدار اولیه Bottom Navigation (Home)
  BottomIconCubit() : super(BottomNavState.home);

  /// تغییر وضعیت به صفحه Home
  void gotoHome() => emit(BottomNavState.home);

  /// تغییر وضعیت به صفحه Bookmark
  void gotoBookMark() => emit(BottomNavState.bookmark);
}

