import 'package:logger/logger.dart';
import 'dart:io';

/// این کلاس مسئول مدیریت لاگ‌ها در اپلیکیشن است.
class LoggerManager {
  late Logger _logger;
  Level _currentLogLevel;

  /// مسیر فایل لاگ
  final String logFilePath;

  static LoggerManager? _instance;

  /// این کارخانه (Factory) برای ایجاد یا بازیابی یک نمونه Singleton از LoggerManager استفاده می‌شود.
  factory LoggerManager({Level logLevel = Level.warning, String logFilePath = 'app_log.txt'}) {
    _instance ??= LoggerManager._internal(logLevel, logFilePath);
    return _instance!;
  }

  LoggerManager._internal(this._currentLogLevel, this.logFilePath) {
    _initializeLogger();
  }

  /// متد برای مقداردهی اولیه به لاگر
  void _initializeLogger() {
    _logger = Logger(
      filter: CustomLogFilter(logLevel: _currentLogLevel),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printTime: true,
      ),
      output: _getLogOutput(),
    );
  }

  /// متد برای دریافت خروجی لاگ‌ها (کنسول و فایل)
  LogOutput _getLogOutput() {
    return MultiOutput([ConsoleOutput(), FileOutput(logFilePath)]);
  }

  /// تغییر سطح لاگ در زمان اجرا
  void setLogLevel(Level level) {
    _currentLogLevel = level;
    _initializeLogger(); // برای به‌روزرسانی لاگر با سطح جدید
  }

  /// دسترسی به لاگر
  Logger get logger => _logger;
}

/// این کلاس برای فیلتر کردن لاگ‌ها بر اساس سطح آن‌ها استفاده می‌شود.
class CustomLogFilter extends LogFilter {
  final Level logLevel;

  CustomLogFilter({required this.logLevel});

  @override
  bool shouldLog(LogEvent event) {
    // لاگ‌ها فقط زمانی ثبت می‌شوند که سطح آن‌ها بزرگتر یا مساوی با سطح فعلی باشد.
    return event.level.index >= logLevel.index;
  }
}

/// این کلاس برای نمایش لاگ‌ها در کنسول است.
class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // چاپ لاگ‌ها در کنسول
    stdout.writeln(event.lines.join('\n'));
  }
}

/// این کلاس برای ذخیره لاگ‌ها در یک فایل استفاده می‌شود.
class FileOutput extends LogOutput {
  final String filePath;

  FileOutput(this.filePath);

  @override
  void output(OutputEvent event) async {
    final logMessage = event.lines.join('\n');
    try {
      final logFile = File(filePath);
      // بررسی وجود فایل و ایجاد آن در صورت نیاز
      if (!await logFile.exists()) {
        await logFile.create(recursive: true);
      }

      // چک کردن اندازه فایل و انجام چرخش فایل در صورت نیاز
      if (await logFile.length() > 10 * 1024 * 1024) { // حجم بیشتر از 10MB
        final rotatedFile = File('$filePath.${DateTime.now().millisecondsSinceEpoch}');
        await logFile.rename(rotatedFile.path); // تغییر نام فایل قدیمی
        await logFile.create(); // ایجاد فایل جدید
      }

      // نوشتن لاگ جدید در فایل
      await logFile.writeAsString('$logMessage\n', mode: FileMode.append);
    } catch (e) {
      // مدیریت خطا در هنگام نوشتن به فایل
      stderr.writeln('Error writing log to file: $e');
    }
  }
}
