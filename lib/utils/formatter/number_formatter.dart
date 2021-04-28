import 'package:intl/intl.dart';

class NumberFormatter {
  static String formatString(String value) {
    return NumberFormat('##,##,##,##,##,###').format(
      int.tryParse(value),
    );
  }
}
