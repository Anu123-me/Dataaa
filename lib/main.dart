import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytest/ui/product_list_screen.dart';
import 'package:provider/provider.dart';

import 'Api/productprovider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product App',
        home: ProductListScreen(),
      ),
    );
  }
}