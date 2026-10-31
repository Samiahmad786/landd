import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/calculator/calculator_screen.dart';
import '../../features/portal/portal_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/onboarding/language_screen.dart';
final appRouter=GoRouter(initialLocation:'/language',routes:[
 GoRoute(path:'/language',builder:(_,__)=>const LanguageScreen()),
 ShellRoute(builder:(c,s,child)=>Scaffold(body:child,bottomNavigationBar:NavigationBar(destinations:const [
  NavigationDestination(icon:Icon(Icons.home),label:'Home'),NavigationDestination(icon:Icon(Icons.calculate),label:'Calculator'),NavigationDestination(icon:Icon(Icons.account_balance),label:'Offices'),NavigationDestination(icon:Icon(Icons.person),label:'Profile')],
  onDestinationSelected:(i)=>GoRouter.of(c).go(['/','/calculator','/offices','/profile'][i]))),routes:[
  GoRoute(path:'/',builder:(_,__)=>const HomeScreen()),
  GoRoute(path:'/calculator',builder:(_,__)=>const CalculatorScreen()),
  GoRoute(path:'/offices',builder:(_,__)=>const HomeScreen()),
  GoRoute(path:'/profile',builder:(_,__)=>const ProfileScreen()),
 ]),
 GoRoute(path:'/portal',builder:(c,s){final x=s.extra as Map<String,String>;return PortalScreen(title:x['title']!,url:x['url']!,state:x['state']!);})
]);
