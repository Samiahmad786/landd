import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/land_config.dart';
import '../home/home_screen.dart';
class CalculatorScreen extends ConsumerStatefulWidget{const CalculatorScreen({super.key});@override ConsumerState<CalculatorScreen> createState()=>_CalcState();}
class _CalcState extends ConsumerState<CalculatorScreen>{
 final value=TextEditingController(text:'1');String unit='Acre';
 @override Widget build(BuildContext c){
 final cfg=ref.watch(landConfigProvider);final sid=ref.watch(stateId);
 return Scaffold(appBar:AppBar(title:const Text('Land Calculator')),body:cfg.when(loading:()=>const Center(child:CircularProgressIndicator()),error:(e,s)=>Text('$e'),data:(x){
 final standard=(x.units[sid]??x.units['default']) as Map<String,dynamic>;final factors=standard['sqftPerUnit'] as Map<String,dynamic>;
 if(!factors.containsKey(unit))unit=factors.keys.first;final sqft=(double.tryParse(value.text)??0)*(factors[unit] as num).toDouble();
 Widget result(String name,double n)=>Card(child:ListTile(title:Text(name),trailing:Text(n.toStringAsFixed(3),style:const TextStyle(fontWeight:FontWeight.bold))));
 return ListView(padding:const EdgeInsets.all(18),children:[
 Text('Standard: ${standard['label']}',style:const TextStyle(fontWeight:FontWeight.bold)),
 const SizedBox(height:12),TextField(controller:value,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:const InputDecoration(labelText:'Enter area'),onChanged:(_)=>setState((){})),
 const SizedBox(height:12),DropdownButtonFormField<String>(value:unit,decoration:const InputDecoration(labelText:'Unit'),items:factors.keys.map((u)=>DropdownMenuItem(value:u,child:Text(u))).toList(),onChanged:(v)=>setState(()=>unit=v!)),
 const SizedBox(height:16),result('Square feet',sqft),result('Square meter',sqft/10.7639104167),result('Decimal',sqft/435.6),result('Acre',sqft/43560),
 const Text('Local unit factors vary by district. Verify official revenue standards before legal or financial use.')
 ]);
 }));
 }
}
