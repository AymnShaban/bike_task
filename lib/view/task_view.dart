import 'package:bike_task/exports.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DiagonalGradientBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: context.screenHeight*.1,
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
    );
  }

  // AppBar removed; now using SliverAppBar in build
}
