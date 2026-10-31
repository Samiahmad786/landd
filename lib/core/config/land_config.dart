import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final landConfigProvider=FutureProvider<LandConfig>((ref)async{
 final s=await rootBundle.loadString('assets/config/india_land_config.json');
 return LandConfig.fromJson(jsonDecode(s) as Map<String,dynamic>);
});
class LandConfig{
 LandConfig(this.states,this.services,this.units);
 final List<Map<String,dynamic>> states;final Map<String,dynamic> services,units;
 factory LandConfig.fromJson(Map<String,dynamic> j)=>LandConfig((j['states'] as List).cast<Map<String,dynamic>>(),j['services'] as Map<String,dynamic>,j['unitStandards'] as Map<String,dynamic>);
}
