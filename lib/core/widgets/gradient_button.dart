import '../../exports.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final double size; // Responsive size (e.g., 60.w or 15% of screen width)
  final LinearGradient? gradient;
  const GradientButton({
    super.key,
    required this.child,
    this.gradient,
    required this.onPressed,
    this.borderRadius = 12.0,
    this.size = 60, // Default size, make it responsive when used
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: gradient?? AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(borderRadius),
            // Optional: Add extra shadow if needed
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            width: (size - 20) * 0.6, // Adjust icon size to fit nicely (60% of button)
            height: (size - 20) * 0.6,
            child: child, // Typically an SVG icon
          ),
        ),
      ),
    );
  }
}