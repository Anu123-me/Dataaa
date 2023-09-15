import 'package:flutter/material.dart';
import 'package:mytest/Api/ApiServides.dart';

import '../model/Products.dart';

class ProductProvider with ChangeNotifier {
  List<Products> _products = [];
  List<Products> get products => _products;
Apiservice apiservice=Apiservice();
  Future<void> fetchProducts() async {

    _products =(await apiservice.fetchdata())!;


    notifyListeners();
  }
}
