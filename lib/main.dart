import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'core/widgets/main_wrapper.dart';
import 'locator_di.dart';

void main() async {
  // اطمینان از آماده بودن تمام وابستگی‌ها قبل از اجرای برنامه
  WidgetsFlutterBinding
      .ensureInitialized(); // برای اطمینان از اینکه برنامه به‌طور کامل راه‌اندازی شده است
  await setup();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // خاموش کردن بنر Debug
    theme: ThemeData(
      primarySwatch: Colors.blue, // می‌توانید تم دلخواه خود را تنظیم کنید
    ),
    home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<HomeBloc>())
        ],
        child:  MainWrapper()),

  ));
}
