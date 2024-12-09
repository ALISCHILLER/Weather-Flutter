import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_flutter/core/widgets/app_background.dart';
import 'package:weather_flutter/core/widgets/dot_loading_widget.dart';
import '../../domain/entites/cureent_city_entity.dart';
import '../bloc/cw_status.dart';
import '../bloc/home_bloc.dart';

/// صفحه اصلی اپلیکیشن (HomeScreen)
/// مدیریت وضعیت‌های آب‌وهوا و نمایش اطلاعات مربوطه
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// نام پیش‌فرض شهر
  String cityName = "Tehran";
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // ارسال رویداد برای بارگذاری اطلاعات آب‌وهوا برای شهر پیش‌فرض
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              // بررسی وضعیت بارگذاری
              if (state.cwStatus is CwLoading) {
                return const Expanded(child: DotLoadingWidget());
              }

              // بررسی وضعیت موفقیت‌آمیز
              if (state.cwStatus is CwCompleted) {
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity =
                    cwCompleted.currentCityEntity;

                // دریافت وضعیت آب‌وهوا به صورت Enum
                WeatherCondition condition = AppBackground.getWeatherCondition(
                    currentCityEntity.weather?[0].description ?? '');

                return Expanded(
                  child: ListView(
                    children: [
                      _buildWeatherInfo(currentCityEntity, condition),
                      const SizedBox(height: 10),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 2,
                          effect: const ExpandingDotsEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 5,
                            activeDotColor: Colors.white,
                          ),
                          onDotClicked: (index) => _pageController.animateToPage(
                            index,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.bounceInOut,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              // بررسی وضعیت خطا
              if (state.cwStatus is CwError) {
                final CwError cwError = state.cwStatus as CwError;
                return _buildStatusWidget("خطا رخ داده است: ${cwError.message}",Colors.red);
              }

              // وضعیت پیش‌فرض (عدم نمایش چیزی)
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  /// متد برای ساخت نمایش وضعیت آب‌وهوا
  Widget _buildWeatherInfo(CurrentCityEntity currentCityEntity, WeatherCondition condition) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SizedBox(
        width: width,
        height: 400,
        child: PageView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          allowImplicitScrolling: true,
          controller: _pageController,
          itemCount: 2,
          itemBuilder: (context, position) {
            if (position == 0) {
              return _buildWeatherDetails(currentCityEntity, condition);
            } else {
              return Container(color: Colors.amber);
            }
          },
        ),
      ),
    );
  }

  /// ویجت برای نمایش اطلاعات دما و وضعیت هوا
  Widget _buildWeatherDetails(CurrentCityEntity currentCityEntity, WeatherCondition condition) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            currentCityEntity.name ?? 'نام شهر در دسترس نیست',
            style: _buildTextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            currentCityEntity.weather?[0].description ?? '',
            style: _buildTextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: AppBackground.getWeatherIcon(condition),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "${currentCityEntity.main!.temp?.round()}\u00b0",
            style: _buildTextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        _buildTemperatureInfo(currentCityEntity),
      ],
    );
  }

  /// ویجت برای نمایش اطلاعات حداکثر و حداقل دما
  Widget _buildTemperatureInfo(CurrentCityEntity currentCityEntity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTempColumn("max", currentCityEntity.main!.tempMax),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(color: Colors.grey, height: 40, thickness: 2),
        ),
        _buildTempColumn("min", currentCityEntity.main!.tempMin),
      ],
    );
  }

  /// ویجت برای نمایش دما
  Widget _buildTempColumn(String label, num? temperature) {
    return Column(
      children: [
        Text(label, style: _buildTextStyle(fontSize: 15)),
        const SizedBox(height: 10),
        Text(
          "${temperature?.round()}\u00b0",
          style: _buildTextStyle(fontSize: 16),
        ),
      ],
    );
  }

  /// متد برای ساخت استایل متن
  TextStyle _buildTextStyle({required double fontSize, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.white,
    );
  }

  /// متد برای نمایش ویجت وضعیت‌ها (مانند پیام خطا)
  Widget _buildStatusWidget(String message,Color color) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 20, color: color),
      ),
    );
  }
}
