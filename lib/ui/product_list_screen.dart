import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mytest/ui/product_list_screen.dart';

import '../Api/productprovider.dart';
import '../model/Products.dart';
import 'p_details.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context).products;
    List<Products> filteredProducts = productsData
        .where((product) =>
            product.title!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            product.brand!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff297c26),
        title: Text('Product List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'Search by Title or Brand',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      ((MediaQuery.of(context).size.height * 0.75)),
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                  product: filteredProducts[index])),
                        );
                      },
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFEEEFF2),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 200,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${filteredProducts[index].thumbnail}',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.white],
                                    stops: [0.0, 0.7], // Adjust the stops as needed
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 90,),
                                    Text(
                                      maxLines:1,
                                      '${filteredProducts[index].title}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: Container(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    maxLines:2,
                                    'Now @ \$${filteredProducts[index].price}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                ),
          ),
        ],
      ),
    );
  }
}
