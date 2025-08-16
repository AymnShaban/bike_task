import 'package:bike_task/exports.dart';

class BikeCoverWidget extends StatelessWidget {
  const BikeCoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.09,
      child: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight * 0.3,
        child: Stack(
          children: [
            // Gradient border
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey, // Start at top right
                    Theme.of(context).primaryColor, // End at bottom left
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            // Inner content with padding for border effect
            Padding(
              padding: const EdgeInsets.all(2.0), // Border thickness
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2C3344),
                      Color(0xFF2C3546),
                      Color(0xFF2F5B80),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.5, 1.0],
                    transform: GradientRotation(-0.2),
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/bike_cover.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            "30% Off",
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: Colors.white.withValues(alpha:0.6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
