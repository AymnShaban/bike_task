import '../../exports.dart';

extension ContextExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppBarThemeData get appBarTheme => Theme.of(this).appBarTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get screenPaddingTop => mediaQuery.padding.top;
  double get screenPaddingBottom => mediaQuery.padding.bottom;
  double get screenPaddingLeft => mediaQuery.padding.left;
  double get screenPaddingRight => mediaQuery.padding.right;
  EdgeInsets get screenPadding => mediaQuery.padding;
  double get appBarHeight => appBarTheme.toolbarHeight ?? kToolbarHeight;
}