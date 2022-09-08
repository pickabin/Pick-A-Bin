import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/network/exceptions/connectivity_provider.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/di/components/service_locator.dart';
import 'package:boilerplate/ui/authentication/role_selection.dart';
import 'package:boilerplate/ui/connection/error_connection.dart';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../data/service/auth_service.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());

  final PostStore _postStore = PostStore(getIt<Repository>());

  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());

  final UserStore _userStore = UserStore(getIt<Repository>());

  void _forgotPassword(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      backgroundColor: Colors.white,
      context: context,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: ErrorConnection(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false)
        .pantauConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: ((context, value, child) {
        return value.isOnline
            ? MultiProvider(
                providers: [
                  Provider<AuthService>(create: (_) => AuthService()),
                  StreamProvider(
                    create: (context) =>
                        context.read<AuthService>().authStateChange,
                    initialData: null,
                  ),
                  Provider<ThemeStore>(create: (_) => _themeStore),
                  Provider<PostStore>(create: (_) => _postStore),
                  Provider<LanguageStore>(create: (_) => _languageStore),
                ],
                child: Observer(
                  name: 'global-observer',
                  builder: (context) {
                    return MaterialApp(
                      showSemanticsDebugger: false,
                      debugShowMaterialGrid: false,
                      debugShowCheckedModeBanner: false,
                      title: Strings.appName,
                      theme: _themeStore.darkMode ? themeDataDark : themeData,
                      routes: Routes.routes,
                      locale: Locale(_languageStore.locale),
                      supportedLocales: _languageStore.supportedLanguages
                          .map((language) =>
                              Locale(language.locale!, language.code))
                          .toList(),
                      localizationsDelegates: [
                        // A class which loads the translations from JSON files
                        AppLocalizations.delegate,
                        // Built-in localization of basic text for Material widgets
                        GlobalMaterialLocalizations.delegate,
                        // Built-in localization for text direction LTR/RTL
                        GlobalWidgetsLocalizations.delegate,
                        // Built-in localization of basic text for Cupertino widgets
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      home: _userStore.isLoggedIn ? NavbarPage() : RoleSelection(),
                    );
                  },
                ),
              )
            : ErrorConnection();
      }),
    );
  }
}
