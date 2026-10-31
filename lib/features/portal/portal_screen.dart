import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PortalScreen extends StatefulWidget{const PortalScreen({super.key,required this.title,required this.url,required this.state});final String title,url,state;@override State<PortalScreen> createState()=>_PortalState();}
class _PortalState extends State<PortalScreen>{
 late final WebViewController web;int progress=0;String? error;
 @override void initState(){super.initState();web=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..setNavigationDelegate(NavigationDelegate(onProgress:(p)=>setState(()=>progress=p),onWebResourceError:(e)=>setState(()=>error=e.description)))..loadRequest(Uri.parse(widget.url));}
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text(widget.title),leading:BackButton(onPressed:()async{if(await web.canGoBack()){web.goBack();}else if(c.mounted)Navigator.pop(c);}),actions:[IconButton(onPressed:()=>web.reload(),icon:const Icon(Icons.refresh))]),body:Column(children:[if(progress<100)LinearProgressIndicator(value:progress/100),Expanded(child:error==null?WebViewWidget(controller:web):Center(child:Column(mainAxisSize:MainAxisSize.min,children:[const Icon(Icons.wifi_off,size:42),Text(error!),FilledButton(onPressed:(){setState(()=>error=null);web.reload();},child:const Text('Retry'))]))),Padding(padding:const EdgeInsets.all(8),child:Text('Data source: Official ${widget.state} portal. This app is not affiliated with any government body.',textAlign:TextAlign.center,style:const TextStyle(fontSize:11)))]));
}
