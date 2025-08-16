import '../../exports.dart';

class TaperedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start at bottom left
    path.moveTo(0, size.height);
    
    // Go to bottom right
    path.lineTo(size.width, size.height);
    
    // Go to top right (higher point)
    path.lineTo(size.width, size.height * 0.2);
    
    // Curve down to center (lower point)
    path.quadraticBezierTo(
      size.width * 0.5, 
      size.height * 0.1, 
      0, 
      size.height * 0.2
    );
    
    // Close the path
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}