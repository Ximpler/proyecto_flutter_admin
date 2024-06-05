import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'ui/flutter_flow/flutter_flow_theme.dart';
import 'ui/flutter_flow/flutter_flow_util.dart';
import 'ui/flutter_flow/nav/nav.dart';
import 'ui/index.dart';
import 'package:loggy/loggy.dart';
import 'data/core/network_info.dart';
import 'ui/controllers/report_controller.dart';
import 'ui/controllers/connectivity_controller.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/use_cases/report_usecase.dart';
import 'data/data_sources/local/local_report_data_source.dart';
import 'data/data_sources/local/i_local_report_datasource.dart';
import 'data/data_sources/remote/i_remote_report_source.dart';
import 'data/data_sources/remote/remote_report_source.dart';
import 'data/repositories/report_repository.dart';
import 'domain/repositories/i_report_repository.dart';

import 'data/models/report_db.dart';

Future<void> _initializeHive() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    Hive.registerAdapter(ReportDbAdapter());
    await Hive.openBox('reportDb');
    await Hive.openBox('reportDbOffline');
    logInfo("Box opened reportDb: ${await Hive.boxExists('reportDb')}");
    logInfo(
        "Box opened reportDbOffline: ${await Hive.boxExists('reportDbOffline')}");
  } catch (e) {
    logError("Error opening Hive boxes: $e");
    rethrow; // Rethrow to see the actual error
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  await _initializeHive();

  Get.put(NetworkInfo());
  Get.put<ILocalReportDataSource>(LocalReportSource());
  Get.put<IRemoteReportSource>(RemoteReportSource());
  print("se logro hasta RemoteReportSource");

  Get.put<IReportRepository>(
      ReportRepository(Get.find(), Get.find(), Get.find()));
  print("se logro hasta ReportRepository");

  Get.put(ReportUseCase(Get.find()));
  print("se logro hasta ReportUseCase");

  Get.put(ConnectivityController());
  Get.put(ReportController());
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Proyecto Flutter Admin',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: ThemeController.to.themeMode,
      getPages: AppPages.pages,
    );
  }
}

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  Rx<ThemeMode> _themeMode = FlutterFlowTheme.themeMode.obs;

  ThemeMode get themeMode => _themeMode.value;

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    FlutterFlowTheme.saveThemeMode(mode);
  }
}

class AppStateNotifier extends GetxController {
  static AppStateNotifier get instance => Get.find();
  // Add your AppStateNotifier content here
}

class AppPages {
  static final pages = [
    GetPage(name: '/', page: () => const HomePageWidget()),
    GetPage(name: '/editor_us', page: () => EditorUsWidget()),
    GetPage(name: '/homepage_uc', page: () => HomepageUcWidget()),
    GetPage(name: '/create_report', page: () => CreateReportWidget()),
    GetPage(name: '/view_report', page: () => ViewReportWidget()),
  ];
}

void createRouter(AppStateNotifier appStateNotifier) {
  // Add your router creation logic here
}
