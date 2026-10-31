import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/localization/locale_controller.dart';
import 'core/navigation/router.dart';
import 'l10n/app_localizations.dart';
class BhumiSaathiApp extends ConsumerWidget {
 const BhumiSaathiApp({super.key});
 @override Widget build(BuildContext context, WidgetRef ref) {
  final code=ref.watch(localeProvider);
  return MaterialApp.router(title:'Bhumi Saathi',debugShowCheckedModeBanner:false,
   theme:ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xff176b45))),
   darkTheme:ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xff176b45),brightness:Brightness.dark)),
   locale:Locale(code),supportedLocales:AppLocalizations.supportedLocales,
   localizationsDelegates:const [AppLocalizations.delegate,GlobalMaterialLocalizations.delegate,GlobalWidgetsLocalizations.delegate,GlobalCupertinoLocalizations.delegate],
   routerConfig:appRouter);
 }
}
