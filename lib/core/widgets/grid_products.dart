
import '../../exports.dart';

class GridProducts extends StatelessWidget {
  const GridProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = List.generate(
      10,
      (index) {
        if (index % 2 == 0) {
          return Product(
            id: index,
            name: "Road Bike",
            price: 100 + index * 10,
            imageUrl: 'assets/images/second_bike.png',
          );
        }
        return Product(
          id: index,
          name: "Road Helmet",
          price: 100 + index * 10,
          imageUrl: 'assets/images/second_helmet.png',
        );
      },
    );

    return GridView.builder(
      gridDelegate: gridDelegate(),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
      shrinkWrap: true, // Add this if inside a scrollable parent
      physics: const NeverScrollableScrollPhysics(), // Add this if inside another scrollable
    );
  }
}class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(product.imageUrl, fit: BoxFit.cover),
          Text(product.name, style: TextStyle(fontSize: 16.sp)),
          Text('\$${product.price}', style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
SliverGridDelegateWithFixedCrossAxisCount gridDelegate() {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 8.w,
    crossAxisSpacing: 8.w,
    childAspectRatio: 0.7, // Adjust aspect ratio for better fit
  );
}
class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}