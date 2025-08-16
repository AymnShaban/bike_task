
import '../../exports.dart';

class FlexibleBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;

  const FlexibleBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  State<FlexibleBottomNavBar> createState() => FlexibleBottomNavBarState();
}

class FlexibleBottomNavBarState extends State<FlexibleBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(_controller);
    _controller.value = 1;
  }

  void show() => _controller.forward();
  void hide() => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TaperedBottomClipper(),
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.backgroundColor,
                AppTheme.secondaryColor,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 1.0],
              transform: GradientRotation(-0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: .2),
                blurRadius: 8,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Container(
            height: context.screenHeight * 0.08,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.items.map((item) => 
                _buildNavItem(item.svgPath, item.index)
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgPath, int index) {
    return GestureDetector(
      onTap: () {
        widget.onTap(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            colorFilter: ColorFilter.mode(
              widget.currentIndex == index
                  ? Theme.of(context).primaryColor
                  : Colors.white.withValues(alpha: .7),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 2.h),
          if (widget.currentIndex == index)
            Container(
              width: 12.w,
              height: 2.h,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }
}

class NavBarItem extends Equatable {
  final String svgPath;
  final int index;

  const NavBarItem({required this.svgPath, required this.index});

  @override
  List<Object?> get props => [svgPath, index];
}