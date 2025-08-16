import '../../exports.dart';

class TaperedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    path.moveTo(0, size.height);
    
    path.lineTo(0, size.height * 0.25); // Adjust this value to control how low the left side starts
    
    // Diagonal line to top-right (higher end point)
    path.lineTo(size.width, 0); // Top-right corner
    
    path.lineTo(size.width, size.height);
    
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}