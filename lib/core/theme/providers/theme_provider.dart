import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage_impl.dart';
import 'package:mis_compras_app/core/theme/theme_config.dart';

part 'theme_state.dart';
part 'theme_notifier.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  ThemeNotifier.new,
);
