import 'package:bike_task/core/widgets/productCard.dart';

import '../../exports.dart';

class GridProducts extends StatelessWidget {
  const GridProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = List.generate(10, (index) {
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
    });

    return BlocProvider(
      create: (context) => getIt<FavoriteBloc>(),
      child: GridView.builder(
        gridDelegate: gridDelegate(),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
        shrinkWrap: true, // Add this if inside a scrollable parent
        physics:
            const NeverScrollableScrollPhysics(), // Add this if inside another scrollable
      ),
    );
  }
}



SliverGridDelegateWithFixedCrossAxisCount gridDelegate() {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 27.w,
    crossAxisSpacing: 15.w,
    childAspectRatio: 0.75, // More square, matches Figma look
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

//
// class ProductCard extends StatelessWidget {
//   final Product product;
//
//   const ProductCard({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//       angle: -0.09,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               const Color(0xFF2C3344),
//               const Color(0xFF2C3546),
//               const Color(0xFF2F5B80),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             stops: [0.0, 0.5, 1.0],
//             transform: GradientRotation(-0.2),
//           ),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: AppTheme.backgroundColor.withValues(alpha: .5),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: .15),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(14.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       BlocSelector<FavoriteBloc, Set<int>, bool>(
//                         selector: (state) => state.contains(product.id),
//                         builder: (context, isFavorite) {
//                           return GestureDetector(
//                             onTap: () {
//                               context.read<FavoriteBloc>().add(
//                                 ToggleFavoriteEvent(product.id),
//                               );
//                             },
//                             child: ShaderMask(
//                               shaderCallback: (Rect bounds) {
//                                 return isFavorite
//                                     ? AppTheme.primaryGradient.createShader(
//                                   bounds,
//                                 )
//                                     : LinearGradient(
//                                   colors: [
//                                     Colors.white.withValues(alpha: .7),
//                                     Colors.white.withValues(alpha: .7),
//                                   ],
//                                 ).createShader(bounds);
//                               },
//                               child: Icon(
//                                 isFavorite
//                                     ? Icons.favorite_border
//                                     : Icons.favorite_border,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Image.asset(
//                         product.imageUrl,
//                         fit: BoxFit.fill,
//
//                       ),
//                     ),
//                   ),
//                   12.verticalSpace,
//                   Text(
//                     product.name,
//                     textScaler: TextScaler.linear(1),
//
//                     style: TextStyle(
//                       fontSize: 15.sp,
//                       color: Colors.white.withValues(alpha: .85),
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   4.verticalSpace,
//                   Text(
//                     product.name == "Road Bike"
//                         ? "PEUGEOT - LR01"
//                         : "SMITH - Trade",
//                     textScaler: TextScaler.linear(1),
//
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   4.verticalSpace,
//                   Text(
//                     '\$${product.price}',
//                     textScaler: TextScaler.linear(2),
//                     style: TextStyle(
//                       fontSize: 15.sp,
//                       color: Colors.white.withValues(alpha: .7),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }