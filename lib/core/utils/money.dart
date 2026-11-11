import 'package:intl/intl.dart';

String formatClp(int value) {
  final number = NumberFormat.decimalPattern('es_CL').format(value);
  return '\$$number';
}
