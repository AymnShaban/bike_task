import '../../exports.dart';

class DiagonalGradientBackground extends StatelessWidget {
  final Widget child;

  const DiagonalGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Base dark background
        Container(color: AppTheme.backgroundColor),

        // 2. Gradient layer with diagonal cut
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: MediaQuery.of(context).size.height * 0.8,
          child: ClipPath(
            clipper: _DiagonalCutClipper(),
            child: Container(
              decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
            ),
          ),
        ),

        // 3. Content
        child,
      ],
    );
  }
}

class _DiagonalCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Start at bottom left
    path.moveTo(0, size.height);
    // Go to bottom right
    path.lineTo(size.width, size.height);
    
    path.lineTo(size.width, size.height/5);
    // Go to top center
    path.lineTo(size.width / 1.25, 0);
    // Close the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
