import 'package:bike_task/exports.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late ScrollController _scrollController;
  bool _showNavBar = true;
  double _lastOffset = 0;
  final GlobalKey<FlexibleBottomNavBarState> _navBarKey = GlobalKey<FlexibleBottomNavBarState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navBarKey.currentState?.show();
    });
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    
    // Add threshold to prevent flickering on iOS
    const threshold = 50.0;
    
    if (offset > _lastOffset + threshold && _showNavBar) {
      if (offset < maxScrollExtent - 100) {
        _showNavBar = false;
        _navBarKey.currentState?.hide();
      }
    } else if (offset < _lastOffset - threshold && !_showNavBar) {
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
    return BlocProvider(
      create: (context) => getIt<BottomNavBloc>(),
      child: Scaffold(
        body: Stack(
          children: [
            DiagonalGradientBackground(
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    
                    floating: true,
                    snap: true,
                    centerTitle: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: context.screenHeight * .1,
                    surfaceTintColor: AppTheme.surfaceColor,
                    title: Text(
                      'Choose Your Bike',
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                       child: GradientButton(
                                   size: 50.w,
                                   onPressed: () {},
                                   child: SvgPicture.asset(
                                     "assets/svg/search.svg",
                                     
                                   ),
                                 ),
                     ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: 20.verticalSpace ,
                  ),
                   SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: BikeCoverWidget(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 20.verticalSpace ,
                  ),
                   SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: CategoryRow(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 20.verticalSpace ,
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
                    sliver: SliverToBoxAdapter(
                      child: GridProducts(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BlocBuilder<BottomNavBloc, int>(
                builder: (context, currentIndex) {
                  return FlexibleBottomNavBar(
                    key: _navBarKey,
                    items: [
                      NavBarItem(svgPath: 'assets/svg/bottom_1.svg', index: 0, label: 'Bikes'),
                      NavBarItem(svgPath: 'assets/svg/bottom_2.svg', index: 1, label: 'Map'),
                      NavBarItem(svgPath: 'assets/svg/bottom_3.svg', index: 2, label: 'Cart'),
                      NavBarItem(svgPath: 'assets/svg/bottom_4.svg', index: 3, label: 'Profile'),
                      NavBarItem(svgPath: 'assets/svg/bottom_5.svg', index: 4, label: 'Documents'),
                    ],
                    currentIndex: currentIndex,
                    onTap: (index) {
                      context.read<BottomNavBloc>().add(BottomNavIndexChanged(index));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
