
import 'package:flutter/services.dart';

import '../../exports.dart';

class FlexibleBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;
  final Duration animationDuration;
  final double height;
  final EdgeInsets? padding;
  final List<Color>? gradientColors;
  final List<BoxShadow>? boxShadow;

  const FlexibleBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.animationDuration = const Duration(milliseconds: 250),
    this.height = 0.08,
    this.padding,
    this.gradientColors,
    this.boxShadow,
  });

  @override
  State<FlexibleBottomNavBar> createState() => FlexibleBottomNavBarState();
}

class FlexibleBottomNavBarState extends State<FlexibleBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;
  
  // Animation controllers for rotation
  late List<AnimationController> _rotationControllers;
  late List<Animation<double>> _rotationAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    
    // Initialize rotation controllers for each item
    _rotationControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    
    _rotationAnimations = _rotationControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: -0.15, // More subtle rotation angle to match Figma
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();
    
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    
    _controller.value = 1;
    
    // Set initial rotation state
    _updateRotationState();
  }

  void _updateRotationState() {
    for (int i = 0; i < _rotationControllers.length; i++) {
      if (i == widget.currentIndex) {
        _rotationControllers[i].forward();
      } else {
        _rotationControllers[i].reverse();
      }
    }
  }

  void show() => _controller.forward();
  void hide() => _controller.reverse();

  @override
  void didUpdateWidget(FlexibleBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _updateRotationState();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _rotationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Bottom navigation bar',
      child: SlideTransition(
        position: _offsetAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            height: context.screenHeight * widget.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.gradientColors ?? [
                  AppTheme.backgroundColor,
                  AppTheme.secondaryColor,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [0.0, 1.0],
                transform: const GradientRotation(-0.2),
              ),
              boxShadow: widget.boxShadow ?? [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none, // Allow items to extend beyond boundaries
              children: [
                // Bottom navigation bar background
                Positioned.fill(
                  child: ClipPath(
                    clipper: TaperedBottomClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: widget.gradientColors ?? [
                            AppTheme.backgroundColor,
                            AppTheme.secondaryColor,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: const [0.0, 1.0],
                          transform: const GradientRotation(-0.2),
                        ),
                      ),
                    ),
                  ),
                ),
                // Navigation items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.items.asMap().entries.map((entry) {
                    final item = entry.value;
                    return _buildNavItem(item.svgPath, item.index, item.label);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgPath, int index, String? label) {
    final bool isSelected = widget.currentIndex == index;
    final rotationAnimation = _rotationAnimations[index];

    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap(index);
        },
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: rotationAnimation.value,
                child: _buildNavItemContent(svgPath, index, label, isSelected),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemContent(String svgPath, int index, String? label, bool isSelected) {
    if (isSelected) {
      // Selected item with elevated appearance
      return Transform.translate(
        offset: const Offset(0, -12), // Reduced elevation to be less dramatic
        child: Container(
          width: 60.w, // Much smaller size
          height: 60.h, // Much smaller size
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              svgPath,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 28.w, // Smaller icon
              height: 28.w, // Smaller icon
              semanticsLabel: label,
            ),
          ),
        ),
      );
    } else {
      // Unselected item
      return Container(
        width: 45.w, // Slightly smaller unselected items
        height: 45.h, // Slightly smaller unselected items
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            svgPath,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.7),
              BlendMode.srcIn,
            ),
            width: 22.w, // Smaller icon
            height: 22.w, // Smaller icon
            semanticsLabel: label,
          ),
        ),
      );
    }
  }
}

class NavBarItem extends Equatable {
  final String svgPath;
  final int index;
  final String? label;

  const NavBarItem({
    required this.svgPath,
    required this.index,
    this.label,
  });

  @override
  List<Object?> get props => [svgPath, index, label];
}