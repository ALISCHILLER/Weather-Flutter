import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/home_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();

    // درخواست داده وضعیت هوا برای شهر تهران
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent("Tehran"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"), // عنوان اپلیکیشن
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // بررسی وضعیت مختلف و نمایش ویجت مناسب
          if (state.cwStatus is CwLoading) {
            return _buildStatusWidget("Loading...");
          }

          if (state.cwStatus is CwCompleted) {
            return _buildStatusWidget("Weather data loaded successfully");
          }

          /// ${state.cwStatus.message}
          if (state.cwStatus is CwError) {
            return _buildStatusWidget("Error occurred: ");
          }

          return const SizedBox(); // در صورتی که هیچ کدام از حالت‌ها فعال نباشد
        },
      ),
    );
  }

  // متد برای ساخت ویجت وضعیت‌ها
  Widget _buildStatusWidget(String message) {
    return Center(
      child: Text(message, style: const TextStyle(fontSize: 20)),
    );
  }
}
