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
import 'domain/use_cases/report_usecase.dart';


Future<List<Box>> _openBox() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.initFlutter(); // Initialize Hive for Flutter
  List<Box> boxList = [];
  boxList.add(await Hive.openBox('userDb'));
  boxList.add(await Hive.openBox('userDbOffline'));
  logInfo("Box opened userDb ${await Hive.boxExists('userDb')}");
  logInfo("Box opened userDbOffline ${await Hive.boxExists('userDbOffline')}");
  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  await _openBox();
  Get.put(NetworkInfo());
  //report
  
  Get.put<ILocalReportDataSource>(LocalReportSource());
  Get.put<IRemoteReportSource>(RemoteReportSource());
  Get.put<IReportRepository>(ReportRepository(Get.find(), Get.find(), Get.find()));
  Get.put(ReportUseCase(Get.find()));
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

  // Aquí va el contenido actual de AppStateNotifier
}

class AppPages {
  static final pages = [
    // Aquí definimos las rutas de nuestra aplicación
    //GetPage(name: '/', page: () => HomePage()), // Ejemplo de una ruta
    GetPage(name: '/', page: () => const HomePageWidget()),
    GetPage(name: '/editor_us', page: () => const EditorUsWidget()),
    GetPage(name: '/homepage_uc', page: () => HomepageUcWidget()),
    GetPage(name: '/create_report', page: () => CreateReportWidget()),
    GetPage(name: '/view_report', page: () => ViewReportWidget()),
  ];
}

void createRouter(AppStateNotifier appStateNotifier) {
  // Aquí va la lógica para crear el router
}
