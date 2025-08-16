import 'package:bike_task/exports.dart';
import '../core/widgets/flexible_bottom_nav_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late ScrollController _scrollController;
  int _currentIndex = 0;
  bool _showNavBar = true;
  double _lastOffset = 0;
  final GlobalKey<FlexibleBottomNavBarState> _navBarKey = GlobalKey<FlexibleBottomNavBarState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > _lastOffset && _showNavBar) {
      // scrolling down
      _showNavBar = false;
      _navBarKey.currentState?.hide();
    } else if (offset < _lastOffset && !_showNavBar) {
      // scrolling up
      _showNavBar = true;
      _navBarKey.currentState?.show();
    }
    _lastOffset = offset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DiagonalGradientBackground(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: context.screenHeight * .1,
                  surfaceTintColor: AppTheme.surfaceColor,
                  title: Text(
                    'Choose Your Bike',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  centerTitle: false,
                  actions: [
                    GradientButton(
                      size: 50.w,
                      onPressed: () {},
                      child: SvgPicture.asset("assets/svg/search.svg"),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BikeCoverWidget(),
                          ),
                          20.verticalSpace,
                          CategoryRow(),
                          20.verticalSpace,
                          GridProducts(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FlexibleBottomNavBar(
              key: _navBarKey,
              items: [
    NavBarItem(svgPath: 'assets/svg/bottom_1.svg', index: 0),
    NavBarItem(svgPath: 'assets/svg/bottom_2.svg', index: 1),
    NavBarItem(svgPath: 'assets/svg/bottom_3.svg', index: 2),
    NavBarItem(svgPath: 'assets/svg/bottom_4.svg', index: 3),
    NavBarItem(svgPath: 'assets/svg/bottom_5.svg', index: 4),
  ],
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

}
