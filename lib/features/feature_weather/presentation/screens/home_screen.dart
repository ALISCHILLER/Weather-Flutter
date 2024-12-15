import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_flutter/core/widgets/app_background.dart';
import 'package:weather_flutter/core/widgets/dot_loading_widget.dart';
import 'package:weather_flutter/features/feature_weather/data/models/city_info_model.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/city_info_entity.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_search_city_usecase.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:weather_flutter/features/feature_weather/presentation/widgets/bookmark_icon.dart';
import 'package:weather_flutter/locator_di.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/data_state.dart';
import '../../../feature_bookmark/presentation/bloc/bookmark_bloc.dart';
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

  TextEditingController textEditingController = TextEditingController();

  GetSearchCityCase getSuggestionCityUseCase = GetSearchCityCase(locator());

  @override
  void initState() {
    super.initState();
    // ارسال رویداد برای بارگذاری اطلاعات آب‌وهوا
 //   BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
 //    BlocProvider.of<HomeBloc>(context).add(LoadFwEvent(forcastParams));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child:
                  TypeAheadField<Data>(
                    builder: (context, textEditingController, focusNode) {
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: height * 0.02,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.fromLTRB(20, height * 0.02, 0, height * 0.02),
                          hintText: "Enter a City...",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onSubmitted: (String prefix) {
                          BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(prefix));
                        },
                      );
                    },
                    suggestionsCallback: (String prefix) async {
                      try {
                        final result = await getSuggestionCityUseCase(prefix);

                        if (result is DataState<CityInfoEntity> && result.data?.data != null) {
                          return result.data!.data!; // لیست شهرها
                        }

                        return <Data>[]; // بازگشت لیست خالی
                      } catch (e) {
                        print("Error in suggestionsCallback: $e");
                        return <Data>[];
                      }
                    },
                    itemBuilder: (context, Data city) {
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(city.name ?? 'No Name'),
                        subtitle: Text(
                            "${city.city ?? 'No Region'}, ${city.country ?? 'No Country'}"),
                      );
                    },
                    onSelected: (Data city) {
                      textEditingController.text = city.name ?? '';
                      BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(city.name ?? ''));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                /// bookmark Icon
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current){
                    if(previous.cwStatus == current.cwStatus){
                      return false;
                    }
                    return true;
                  },
                  builder: (context, state) {

                    /// show Loading State for Cw
                    if (state.cwStatus is CwLoading) {
                      return const CircularProgressIndicator();
                    }

                    /// show Error State for Cw
                    if (state.cwStatus is CwError) {
                      return IconButton(
                        onPressed: (){
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //   content: Text("please load a city!"),
                          //   behavior: SnackBarBehavior.floating, // Add this line
                          // ));
                        },
                        icon: const Icon(Icons.error,color: Colors.white,size: 35),);
                    }


                    /// show Completed State for Cw
                    if (state.cwStatus is CwCompleted) {
                      final CwCompleted cwComplete = state.cwStatus as CwCompleted;
                      BlocProvider.of<BookmarkBloc>(context).add(GetCityByNameEvent(cwComplete.currentCityEntity.name!));
                      return BookMarkIcon(name: cwComplete.currentCityEntity.name!);
                    }

                    /// show Default value
                    return Container();

                  },
                ),
              ],
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.cwStatus != current.cwStatus,
            builder: (context, state) {
              if (state.cwStatus is CwLoading) {
                return const DotLoadingWidget();
              }

              if (state.cwStatus is CwCompleted) {
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity = cwCompleted.currentCityEntity;

                WeatherCondition condition = AppBackground.getWeatherCondition(
                    currentCityEntity.weather?[0].description ?? '');

                BlocProvider.of<HomeBloc>(context).add(
                  LoadFwEvent(
                    ForcastParams(
                      currentCityEntity.coord!.lat ?? 0.0, // مقدار پیش‌فرض 0.0
                      currentCityEntity.coord!.lon ?? 0.0, // مقدار پیش‌فرض 0.0
                    ),
                  ),
                );


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
        ));
  }

  Widget DaysWeatherView(Collection daily, int index) {
    // تبدیل به DateTime در قالب UTC
    // تبدیل به DateTime
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(daily.dt! * 1000, isUtc: true);
    // فرمت دلخواه: ماه به حروف، روز به عدد، ساعت و دقیقه
    String formattedDate =
        DateFormat('MMMM d, HH:mm').format(dateTime.toLocal());
    WeatherCondition condition =
        AppBackground.getWeatherCondition(daily.weather?[0].description ?? '');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // اضافه کردن فاصله از چپ و راست
      child: Column(
        children: [
          Text("${formattedDate}", style: _buildTextStyle(fontSize: 16)),
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
