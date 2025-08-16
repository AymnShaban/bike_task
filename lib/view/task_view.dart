import 'package:bike_task/exports.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: DiagonalGradientBackground(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BikeCoverWidget()
             ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Choose Your Bike', style: TextStyle(fontSize: 20.sp)),
      centerTitle: false,
      actions: [
        GradientButton(
          size: 50.w,
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/svg/search.svg",
            
          ),
        ),
      ],
    );
  }
}
