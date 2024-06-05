import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:proyecto_flutter_admin/data/data_sources/local/local_user_support_data_source.dart';
import 'package:proyecto_flutter_admin/data/models/user_support_db.dart';

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

import 'data/data_sources/remote/i_remote_normal_user_source.dart';
import 'data/data_sources/remote/remote_normal_user_source.dart';
import 'data/repositories/normal_user_repository.dart';
import 'domain/repositories/i_normal_user_repository.dart';
import 'package:proyecto_flutter_admin/domain/use_cases/normal_user_usecase.dart';
import 'package:proyecto_flutter_admin/ui/controllers/normal_user_controller.dart';

import 'domain/use_cases/report_usecase.dart';
import 'data/data_sources/local/local_report_data_source.dart';
import 'data/data_sources/local/i_local_report_datasource.dart';
import 'data/data_sources/remote/i_remote_report_source.dart';
import 'data/data_sources/remote/remote_report_source.dart';
import 'data/repositories/report_repository.dart';
import 'domain/repositories/i_report_repository.dart';
import 'data/models/report_db.dart';

import 'package:proyecto_flutter_admin/domain/entities/user_support.dart';
import 'domain/repositories/i_user_support_repository.dart';
import 'package:proyecto_flutter_admin/domain/repositories/i_user_support_repository.dart';
import 'package:proyecto_flutter_admin/data/repositories/user_support_repository.dart';
import 'package:proyecto_flutter_admin/domain/use_cases/user_support_usecase.dart';
import 'package:proyecto_flutter_admin/ui/controllers/user_support_controller.dart';
import 'data/data_sources/local/i_local_user_support_datasource.dart';
import 'data/data_sources/remote/i_remote_user_support_source.dart';
import 'data/data_sources/remote/remote_user_support_source.dart';

Future<void> _initializeHive() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    Hive.registerAdapter(ReportDbAdapter());
    Hive.registerAdapter(UserSupportDbAdapter());
    await Hive.openBox('reportDb');
    await Hive.openBox('reportDbOffline');
    await Hive.openBox('user_supportDb');
    await Hive.openBox('user_supportDbOffline');
    logInfo("Box opened reportDb: ${await Hive.boxExists('reportDb')}");
    logInfo(
        "Box opened reportDbOffline: ${await Hive.boxExists('reportDbOffline')}");
    logInfo("Box opened reportDb: ${await Hive.boxExists('user_supportDb')}");
    logInfo(
        "Box opened reportDbOffline: ${await Hive.boxExists('user_supportDbOffline')}");
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
  Get.put<ILocalUserSupportDataSource>(LocalUserSupportSource());

  Get.put<IRemoteReportSource>(RemoteReportSource());
  Get.put<IRemoteUserSupportSource>(RemoteUserSupportSource());
  Get.put<IRemoteNormalUserSource>(RemoteNormalUserSource());

  Get.put<IReportRepository>(
      ReportRepository(Get.find(), Get.find(), Get.find()));
  Get.put<IUserSupportRepository>(
      UserSupportRepository(Get.find(), Get.find(), Get.find()));
  Get.put<INormalUserRepository>(NormalUserRepository(Get.find()));

  Get.put(ReportUseCase(Get.find()));
  Get.put(UserSupportUseCase(Get.find()));
  Get.put(NormalUserUseCase(Get.find()));

  Get.put(ConnectivityController());
  Get.put(UserSupportController());
  Get.put(ReportController());
  Get.put(ThemeController());
  Get.put(NormalUserController());

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
    GetPage(
      name: '/create_report',
      page: () {
        final int id = Get.arguments as int;
        return CreateReportWidget(id: id);
      },
    ),
    GetPage(
      name: '/view_report',
      page: () {
        final UserSupport userSupport = Get.arguments;
        return ViewReportWidget(userSupport);
      },
    ),
  ];
}

void createRouter(AppStateNotifier appStateNotifier) {
  // Add your router creation logic here
}
