import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/routes.dart';
import 'presentation/cubit/user_status_cubit.dart';
import 'utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await serviceLocatorInit();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ko')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      child: const MirApp(),
    ),
  );
}

class MirApp extends StatelessWidget {
  const MirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => UserStatusCubit())],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'title'.tr(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.gamjaFlower().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
