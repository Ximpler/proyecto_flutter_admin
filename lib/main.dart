import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'ui/flutter_flow/flutter_flow_theme.dart';
import 'ui/flutter_flow/flutter_flow_util.dart';
import 'ui/flutter_flow/nav/nav.dart';
import 'ui/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

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