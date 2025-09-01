import 'package:bike_task/exports.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.product});
final Product product;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Details"),
      ),
    );
  }
}
