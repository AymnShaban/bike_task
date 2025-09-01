import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../../view/blocs/favorite_bloc/favorite_bloc.dart';
import '../../view/details_view.dart';
import 'grid_products.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  void _handleLongPress(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (dialogContext) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 250.w,
                height: 350.h,
                child: _ExplosionDialog(
                  product: product,
                  onAnimationComplete: () {
                    Duration(seconds: 7);
                  },
                ),
              ),
            ),
            Positioned(
                bottom: 160,
                right: 160,
                child: IconButton(onPressed: () {
                  Navigator.pop(dialogContext);

                }, icon: Icon(Icons.close,size: 40, color:Color(0xFF2F5B80), )))
          ],
        );
      },
    );
  }

  void _handleTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsView(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      onLongPress: () => _handleLongPress(context),
      child: _buildCardContent(product, showFavorite: true),
    );
  }
}

Widget _buildCardContent(Product product, {required bool showFavorite}) {
  return Transform.rotate(
    angle: -0.09,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2C3344),
            const Color(0xFF2C3546),
            const Color(0xFF2F5B80),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
          transform: GradientRotation(-0.2),
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.backgroundColor.withValues(alpha: .5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showFavorite)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocSelector<FavoriteBloc, Set<int>, bool>(
                    selector: (state) => state.contains(product.id),
                    builder: (context, isFavorite) {
                      return GestureDetector(
                        onTap: () {
                          context.read<FavoriteBloc>().add(
                                ToggleFavoriteEvent(product.id),
                              );
                        },
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return isFavorite
                                ? AppTheme.primaryGradient.createShader(bounds)
                                : LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: .7),
                                      Colors.white.withValues(alpha: .7),
                                    ],
                                  ).createShader(bounds);
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            Expanded(
              child: Center(
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            12.verticalSpace,
            Text(
              product.name,
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white.withValues(alpha: .85),
                fontWeight: FontWeight.w400,
              ),
            ),
            4.verticalSpace,
            Text(
              product.name == "Road Bike" ? "PEUGEOT - LR01" : "SMITH - Trade",
              textScaler: TextScaler.linear(1),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            4.verticalSpace,
            Text(
              '\$${product.price}',
              textScaler: TextScaler.linear(2),
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white.withValues(alpha: .7),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ExplosionDialog extends StatefulWidget {
  final Product product;
  final VoidCallback onAnimationComplete;

  const _ExplosionDialog({
    required this.product,
    required this.onAnimationComplete,
  });

  @override
  _ExplosionDialogState createState() => _ExplosionDialogState();
}

class _ExplosionDialogState extends State<_ExplosionDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward().then((_) {
      widget.onAnimationComplete();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            _buildCardContent(widget.product, showFavorite: false),
            Positioned.fill(
              child: CustomPaint(
                painter: ExplosionPainter(_animation.value),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ExplosionPainter extends CustomPainter {
  final double animationValue;

  ExplosionPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withValues(alpha: 0.5 * (1 - animationValue));

    final random = math.Random();
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 30; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final distance = random.nextDouble() * size.width * 0.5 * animationValue;
      final particleSize = random.nextDouble() * 6 + 3;

      final particleX = center.dx + math.cos(angle) * distance;
      final particleY = center.dy + math.sin(angle) * distance;

      canvas.drawCircle(
        Offset(particleX, particleY),
        particleSize * (1 - animationValue),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Placeholder for AppTheme (you should have this defined elsewhere)
class AppTheme {
  static const backgroundColor = Colors.black; // Example color
  static const primaryGradient = LinearGradient(
    colors: [Colors.blue, Colors.purple], // Example gradient
  );
}
