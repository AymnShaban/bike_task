import 'package:bike_task/exports.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(svgPath: "assets/svg/battery.svg", id: 1),
      Category(svgPath: "assets/svg/road.svg", id: 2),
      Category(svgPath: "assets/svg/pyramid.svg", id: 3),
      Category(svgPath: "assets/svg/helmet.svg", id: 4),
    ];
    return BlocProvider(
      create: (context) => getIt<SelectCategoryBloc>(),
      child: Transform.rotate(
        angle: -0.09,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withValues(alpha:0.6),
                    Colors.grey.withValues(alpha:0.9),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocSelector<SelectCategoryBloc, int, bool>(
                  selector: (state) => state == 0,
                  builder: (context, isSelected) {
                    return GradientButton(
                      onPressed: () {
                        context.read<SelectCategoryBloc>().add(
                          SelectCategoryEvent(Category(svgPath: '', id: 0)),
                        );
                      },
                      gradient: isSelected
                          ? AppTheme.primaryGradient
                          : LinearGradient(
                              colors: [
                                Colors.grey.withValues(alpha:0.6),
                                AppTheme.backgroundColor.withValues(alpha:0.6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              transform: GradientRotation(-0.2),
                            ),
                      size: 60.w,
                      child: Text(
                        'All',
                    textScaler: TextScaler.linear(1),

                        style: context.textTheme.headlineSmall?.copyWith(
                          fontSize: 20.sp,
                          color: Colors.white,
                          
                        ),
                      ),
                    );
                  },
                ),
                ...categories.map((category) {
                  return BlocSelector<SelectCategoryBloc, int, bool>(
                    selector: (state) => state == category.id,
                    builder: (context, isSelected) {
                      return _buildCategoryItem(
                        context,
                        category,
                        categories.indexOf(category),
                        isSelected,
                      );
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    Category category,
    int index,
    bool isSelected,
  ) {
    return GradientButton(
      onPressed: () {
        context.read<SelectCategoryBloc>().add(SelectCategoryEvent(category));
      },
      size: 60.w,
      gradient: isSelected
          ? AppTheme.primaryGradient
          : LinearGradient(
              colors: index > 1 ? firstGradient : lastGradient,
              stops: [0.0, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(-0.2),
            ),
      borderRadius: 12.0,
      child: SvgPicture.asset(category.svgPath),
    );
  }

  List<Color> get firstGradient {
    return [
      AppTheme.primaryGradient.colors[0].withValues(alpha:0.6),
      AppTheme.primaryGradient.colors[1].withValues(alpha:0.5),
    ];
  }

  List<Color> get lastGradient {
    return [
      Colors.grey.withValues(alpha:0.6),
      AppTheme.backgroundColor.withValues(alpha:0.6),
    ];
  }
}

class Category extends Equatable {
  final String svgPath;
  final int id;
  const Category({required this.svgPath, required this.id});

  @override
  List<Object?> get props => [svgPath, id];
}
