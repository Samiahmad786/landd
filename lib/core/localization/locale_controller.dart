import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
final localeProvider=StateNotifierProvider<LocaleController,String>((ref)=>LocaleController()..load());
class LocaleController extends StateNotifier<String>{
 LocaleController():super('en');
 Future<void> load() async {final p=await SharedPreferences.getInstance();state=p.getString('locale')??'en';}
 Future<void> set(String v) async {state=v;final p=await SharedPreferences.getInstance();await p.setString('locale',v);}
}
