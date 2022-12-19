import 'package:flutter/widgets.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}
