import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/localization/locale_controller.dart';
class LanguageScreen extends ConsumerWidget{
 const LanguageScreen({super.key});
 static const langs={'hi':'हिन्दी','en':'English','bn':'বাংলা','mr':'मराठी','gu':'ગુજરાતી','pa':'ਪੰਜਾਬੀ','or':'ଓଡ଼ିଆ','ta':'தமிழ்','te':'తెలుగు'};
 @override Widget build(BuildContext c,WidgetRef r)=>Scaffold(appBar:AppBar(title:const Text('Choose language')),body:ListView(padding:const EdgeInsets.all(16),children:[
 const Text('भाषा चुनें / Select your language',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
 ...langs.entries.map((e)=>Card(child:ListTile(title:Text(e.value,style:const TextStyle(fontSize:18)),trailing:const Icon(Icons.arrow_forward),onTap:()async{await r.read(localeProvider.notifier).set(e.key);if(c.mounted)c.go('/');})))
 ]));
}
