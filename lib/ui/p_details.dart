import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/Products.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products product; // Pass the selected product as a parameter

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use CarouselSlider for the product images
            Container(
              height: 300,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300, // Adjust the height as needed
                      aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                    ),
                    items: product.images?.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            image,
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    top: 20,
                    right: 40,
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color:  Colors.white70,

                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow, // You can adjust the color as needed
                          ),
                          Text('${product.rating}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              ' ${product.title}',
              style: TextStyle(
                fontSize: 24.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make the text bold
                color: Colors.blue, // Change the text color
                // You can also set a background color if you want to highlight the title.
                // backgroundColor: Colors.yellow,
              ),
            ),


            Text(' ${product.description}'),
            Text('Price: \$${product.price}'),
            Text('Discount Percentage: ${product.discountPercentage}%'),

            Text('Stock: ${product.stock}'),
            Text('Brand: ${product.brand}'),
          ],
        ),
      ),
    );
  }
}
