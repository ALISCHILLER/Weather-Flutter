import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_flutter/core/widgets/app_background.dart';
import 'package:weather_flutter/core/widgets/dot_loading_widget.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/fw_status.dart';
import '../../data/models/forecast_day_model.dart';
import '../../domain/entites/cureent_city_entity.dart';
import '../../domain/entites/forecast_day_entity.dart';
import '../bloc/cw_status.dart';
import '../bloc/home_bloc.dart';

/// صفحه اصلی اپلیکیشن (HomeScreen)
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cityName = "Tehran";
  final PageController _pageController = PageController();
  final ForcastParams forcastParams = ForcastParams(35.7219, 51.3347);

  @override
  void initState() {
    super.initState();
    // ارسال رویداد برای بارگذاری اطلاعات آب‌وهوا
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
    BlocProvider.of<HomeBloc>(context).add(LoadFwEvent(forcastParams));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.cwStatus != current.cwStatus,
            builder: (context, state) {
              if (state.cwStatus is CwLoading) {
                return const DotLoadingWidget();
              }

              if (state.cwStatus is CwCompleted) {
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity = cwCompleted.data;

                WeatherCondition condition = AppBackground.getWeatherCondition(
                    currentCityEntity.weather?[0].description ?? '');

                return Expanded(
                  child: ListView(
                    children: [
                      _buildWeatherInfo(currentCityEntity, condition),
                      const SizedBox(height: 10),
                      _buildPageIndicator(),
                      _buildWeather7Days(),
                    ],
                  ),
                );
              }

              if (state.cwStatus is CwError) {
                final CwError cwError = state.cwStatus as CwError;
                return _buildStatusWidget(
                    "خطا رخ داده است: ${cwError.message}", Colors.red);
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Center(
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
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(
      CurrentCityEntity currentCityEntity, WeatherCondition condition) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SizedBox(
        width: width,
        height: 400,
        child: PageView.builder(
          controller: _pageController,
          itemCount: 2,
          itemBuilder: (context, position) {
            if (position == 0) {
              return _buildWeatherDetails(currentCityEntity, condition);
            } else {
              return Container(color: Colors.amber); // صفحه دوم
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeather7Days() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SizedBox(
        width: width,
        height: 100,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, state) {
            if (state.fwStatus is FwLoading) {
              return const DotLoadingWidget();
            }

            if (state.fwStatus is FwCompleted) {
              final FwCompleted fwCompleted = state.fwStatus as FwCompleted;
              final ForecastDayEntity forecastDaysEntity = fwCompleted.data;
              final List<Collection> mainDaily = forecastDaysEntity.list!;

              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: mainDaily.length,
                itemBuilder: (BuildContext context, int index) {
                  return DaysWeatherView(mainDaily[index], index);
                },
              );
            }

            if (state.fwStatus is FwError) {
              final FwError fwError = state.fwStatus as FwError;
              return _buildStatusWidget(
                  "خطا رخ داده است: ${fwError.message}", Colors.red);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget DaysWeatherView(Collection daily, int index) {
    WeatherCondition condition =
        AppBackground.getWeatherCondition(daily.weather?[0].description ?? '');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // اضافه کردن فاصله از چپ و راست
      child: Column(
        children: [
          Text(daily.weather?[0].main ?? '',
              style: _buildTextStyle(fontSize: 16)),
          AppBackground.getWeatherIcon(condition),
          Text("${daily.main!.temp?.round()}\u00B0",
              style: _buildTextStyle(fontSize: 16)),
        ],
      ),
    );
  }

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
          padding: const EdgeInsets.only(top: 20),
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

  Widget _buildTempColumn(String title, num? temp) {
    return Column(
      children: [
        Text(title, style: _buildTextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Text("${temp?.round()}\u00B0", style: _buildTextStyle(fontSize: 18)),
      ],
    );
  }

  TextStyle _buildTextStyle(
      {double fontSize = 16, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  Widget _buildStatusWidget(String message, Color color) {
    return Center(
      child: Text(message, style: TextStyle(color: color)),
    );
  }
}
