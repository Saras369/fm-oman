import 'dart:developer';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/locale/app_locale_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../modules/network_service.dart';
import '../modules/router/app_router.dart';
import '../modules/router/observer/print_route_observer.dart';
import '../utils/app_extensions/app_extension.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkService().startMonitoring();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    NetworkService().stopMonitoring();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      log('[AppState] App resumed');
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      log('[AppState] App in background');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            currentTheme.themeBox.colors.primary, // Transparent status bar
        statusBarIconBrightness: Brightness.dark, // Icons in dark mode
        systemNavigationBarColor: Colors.white, // Navigation bar color
        systemNavigationBarIconBrightness:
            Brightness.dark, // Icons in dark mode
      ),
    );

    return Consumer(
      builder: (context, ref, child) {
        // final _ = ref.watch(appBooterProvider);
        final currentTheme = ref.watch(KAppX.theme.current);
        final locale = ref.watch(appLocaleProvider);

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
            locale: locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'FM',
            color: currentTheme.themeBox.colors.primary,
            theme: ThemeData(
              primaryColor: currentTheme.themeBox.colors.primary,
              useMaterial3: true,
              // brightness: currentTheme.type == KThemeType.dark
              //     ? Brightness.dark
              //     : Brightness.light,
              brightness: Brightness.light,
              iconTheme: Theme.of(context).iconTheme.copyWith(
                color: currentTheme.themeBox.colors.secondary.shade60,
                size: 24.toAutoScaledHeight,
              ),
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                backgroundColor: currentTheme.themeBox.colors.primary,
                iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: currentTheme.themeBox.colors.secondary.shade60,
                  size: 24.toAutoScaledHeight,
                ),
              ),
              // fontFamily: 'Circular Std',
              shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
              // textTheme: TextTheme(
              //   headline1: _buildTextStyle(),
              //   headline2: _buildTextStyle(),
              //   headline3: _buildTextStyle(),
              //   headline4: _buildTextStyle(),
              //   headline5: _buildTextStyle(),
              //   headline6: _buildTextStyle(),
              //   subtitle1: _buildTextStyle(),
              //   subtitle2: _buildTextStyle(),
              //   bodyText1: _buildTextStyle(),
              //   bodyText2: _buildTextStyle(),
              //   caption: _buildTextStyle(),
              //   button: _buildTextStyle(),
              //   overline: _buildTextStyle(),
              // ),
            ),
            routerConfig: appRouter.config(
              navigatorObservers: () => [PrintRouteObserver()],
            ),
            scrollBehavior: CupertinoScrollBehavior(),
            builder: (context, child) {
              // Can add wrapper over app here
              return child!;
            },
          ),
        );
      },
    );
  }

  // TextStyle _buildTextStyle() {
  //   return TextStyle(
  //     fontFamily: 'Circular Std',
  //     letterSpacing: 0.2,
  //   );
  // }
}
