import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/land_config.dart';
final stateId=StateProvider<String>((r)=>'BR');
final district=StateProvider<String?>((r)=>null);
class HomeScreen extends ConsumerWidget{
 const HomeScreen({super.key});
 @override Widget build(BuildContext c,WidgetRef r){
  final data=r.watch(landConfigProvider);
  return Scaffold(appBar:AppBar(title:const Text('Bhumi Saathi'),actions:[IconButton(onPressed:()=>c.go('/profile'),icon:const Icon(Icons.person))]),
  body:data.when(loading:()=>const Center(child:CircularProgressIndicator()),error:(e,s)=>Center(child:Text('$e')),data:(cfg){
   final sid=r.watch(stateId);final st=cfg.states.firstWhere((x)=>x['id']==sid,orElse:()=>cfg.states.first);
   final ds=(st['districts'] as List).cast<String>();final d=r.watch(district);
   final labels=(cfg.services[sid]??cfg.services['default']) as Map<String,dynamic>;
   final items=[['records',Icons.description],['map',Icons.map],['plot',Icons.search],['mutation',Icons.fact_check],['revenue',Icons.payments],['offices',Icons.account_balance],['help',Icons.help]];
   return ListView(padding:const EdgeInsets.all(16),children:[
    const Text('Find your land services',style:TextStyle(fontSize:23,fontWeight:FontWeight.bold)),
    const SizedBox(height:16),
    DropdownButtonFormField<String>(value:sid,decoration:const InputDecoration(labelText:'Select State / UT'),items:cfg.states.map((s)=>DropdownMenuItem(value:s['id'] as String,child:Text(s['name'] as String))).toList(),onChanged:(v){r.read(stateId.notifier).state=v!;r.read(district.notifier).state=null;}),
    const SizedBox(height:12),
    DropdownButtonFormField<String>(key:ValueKey(sid),value:ds.contains(d)?d:null,decoration:const InputDecoration(labelText:'Select District'),items:ds.map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>r.read(district.notifier).state=v),
    const SizedBox(height:18),
    GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),itemCount:items.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing:12,crossAxisSpacing:12,childAspectRatio:1.1),itemBuilder:(ctx,i){
     final key=items[i][0] as String;final title=labels[key] as String? ?? key;
     return Card(child:InkWell(borderRadius:BorderRadius.circular(18),onTap:(){final urls=st['portals'] as Map<String,dynamic>;final url=urls[key] as String? ?? urls['records'] as String; c.push('/portal',extra:{'title':title,'url':url,'state':st['name'] as String});},child:Padding(padding:const EdgeInsets.all(12),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(items[i][1] as IconData,size:38),const SizedBox(height:10),Text(title,textAlign:TextAlign.center,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w600))]))));
    }),
    const SizedBox(height:18),const Center(child:Text('Developed by Sami Sajjad')),const Center(child:Text('Independent app • Not a government service',style:TextStyle(fontSize:12)))
   ]);
  }));
 }
}
