import 'package:flutter/material.dart';
import 'Viwes/HomeViwes.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      title: 'Meu App',
      home: HomeViews(),  
    );
  }}
