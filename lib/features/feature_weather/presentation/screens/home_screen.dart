import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_flutter/core/widgets/app_background.dart';
import 'package:weather_flutter/core/widgets/dot_loading_widget.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/forcast_day_entites.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/fw_status.dart';
import '../../data/models/ForecastDaysModel.dart';
import '../../domain/entites/cureent_city_entity.dart';
import '../bloc/cw_status.dart';
import '../bloc/home_bloc.dart';

/// صفحه اصلی اپلیکیشن (HomeScreen)
/// این صفحه به مدیریت وضعیت‌های مختلف آب‌وهوا و نمایش اطلاعات مربوط به وضعیت آب‌وهوا برای شهرها می‌پردازد.
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// نام پیش‌فرض شهر (در اینجا تهران)
  String cityName = "Tehran";
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // ارسال رویداد برای بارگذاری اطلاعات آب‌وهوا برای شهر پیش‌فرض (تهران)
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              if (previous.cwStatus == previous.cwStatus) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              // بررسی وضعیت بارگذاری اطلاعات آب‌وهوا
              if (state.cwStatus is CwLoading) {
                return const Expanded(child: DotLoadingWidget());
              }

              // بررسی وضعیت موفقیت‌آمیز بارگذاری اطلاعات
              if (state.cwStatus is CwCompleted) {
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity = cwCompleted.data;

                // دریافت وضعیت آب‌وهوا به صورت Enum
                WeatherCondition condition = AppBackground.getWeatherCondition(
                    currentCityEntity.weather?[0].description ?? '');

                return Expanded(
                  child: ListView(
                    children: [
                      _buildWeatherInfo(currentCityEntity, condition),
                      // نمایش اطلاعات وضعیت آب‌وهوا
                      const SizedBox(height: 10),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 2, // تعداد صفحات برای نمایش در PageView
                          effect: const ExpandingDotsEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 5,
                            activeDotColor: Colors.white, // رنگ نقطه فعال
                          ),
                          onDotClicked: (index) =>
                              _pageController.animateToPage(
                            index,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.bounceInOut,
                          ),
                        ),
                      ),
                      _buidWeathers7Days(),
                    ],
                  ),
                );
              }

              // بررسی وضعیت خطا در بارگذاری اطلاعات آب‌وهوا
              if (state.cwStatus is CwError) {
                final CwError cwError = state.cwStatus as CwError;
                return _buildStatusWidget(
                    "خطا رخ داده است: ${cwError.message}", Colors.red);
              }

              // وضعیت پیش ‌فرض: زمانی که هیچ چیز برای نمایش وجود ندارد
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  /// متد برای ساخت نمایش وضعیت آب‌وهوا
  Widget _buildWeatherInfo(
      CurrentCityEntity currentCityEntity, WeatherCondition condition) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SizedBox(
        width: width,
        height: 400, // ارتفاع ثابت برای نمایش وضعیت آب‌وهوا
        child: PageView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          allowImplicitScrolling: true,
          controller: _pageController,
          itemCount: 2,
          // تعداد صفحات
          itemBuilder: (context, position) {
            if (position == 0) {
              return _buildWeatherDetails(
                  currentCityEntity, condition); // نمایش اطلاعات آب‌وهوا
            } else {
              return Container(color: Colors.amber); // صفحه دوم
            }
          },
        ),
      ),
    );
  }

  Widget _buidWeathers7Days() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SizedBox(
        width: width,
        height: 100,
        child: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
                builder: (BuildContext context, state) {
              if (state.fwStatus is FwLoading) {
                return const Expanded(child: DotLoadingWidget());
              }

              if (state.fwStatus is FwCompleted) {
                final FwCompleted fwCompleted = state.fwStatus as FwCompleted;
                final ForecastDaysEntity forecastDaysEntity = fwCompleted.data;
                final List<Daily> mainDaily = forecastDaysEntity.daily!;

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return DaysWeatherView(mainDaily[index],);
                  },
                );
              }
              // بررسی وضعیت خطا در بارگذاری اطلاعات آب‌وهوا
              if (state.fwStatus is FwError) {
                final FwError fwError = state.fwStatus as FwError;
                return _buildStatusWidget(
                    "خطا رخ داده است: ${fwError.message}", Colors.red);
              }
              // وضعیت پیش ‌فرض: زمانی که هیچ چیز برای نمایش وجود ندارد
              return const SizedBox();
            }),
          ),
        ),
      ),
    );
  }

  Widget DaysWeatherView(Daily daily) {
    WeatherCondition condition =
        AppBackground.getWeatherCondition(daily.weather?[0].description ?? '');
    return Column(
      children: [
        Text(
          daily.dt.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontStyle: FontStyle.normal),
        ),
        AppBackground.getWeatherIcon(condition),
        Text("${daily.temp!.day!.round()} \u00B0",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.normal)),
      ],
    );
  }

  /// ویجت برای نمایش جزئیات آب‌وهوا (شامل نام شهر، وضعیت و دما)
  Widget _buildWeatherDetails(
      CurrentCityEntity currentCityEntity, WeatherCondition condition) {
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
          child: AppBackground.getWeatherIcon(
              condition), // نمایش آیکون وضعیت آب‌وهوا
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "${currentCityEntity.main!.temp?.round()}\u00b0",
            // نمایش دمای کنونی
            style: _buildTextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        _buildTemperatureInfo(currentCityEntity), // نمایش دمای حداقل و حداکثر
      ],
    );
  }

  /// ویجت برای نمایش اطلاعات حداکثر و حداقل دما
  Widget _buildTemperatureInfo(CurrentCityEntity currentCityEntity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTempColumn("max", currentCityEntity.main!.tempMax), // دمای حداکثر
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(color: Colors.grey, height: 40, thickness: 2),
        ),
        _buildTempColumn("min", currentCityEntity.main!.tempMin), // دمای حداقل
      ],
    );
  }

  /// ویجت برای نمایش دما با استفاده از برچسب (max یا min)
  Widget _buildTempColumn(String label, num? temperature) {
    return Column(
      children: [
        Text(label, style: _buildTextStyle(fontSize: 15)),
        const SizedBox(height: 10),
        Text(
          "${temperature?.round()}\u00b0", // نمایش دما به فارنهایت یا سلسیوس
          style: _buildTextStyle(fontSize: 16),
        ),
      ],
    );
  }

  /// متد برای ساخت استایل متن (فونت و اندازه)
  TextStyle _buildTextStyle(
      {required double fontSize, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.white, // رنگ متن سفید
    );
  }

  /// متد برای نمایش ویجت وضعیت‌ها (مانند پیام خطا)
  Widget _buildStatusWidget(String message, Color color) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 20, color: color),
      ),
    );
  }
}
