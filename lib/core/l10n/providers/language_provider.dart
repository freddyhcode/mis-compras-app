import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage_impl.dart';

part 'language_state.dart';
part 'language_notifier.dart';

final languageProvider = NotifierProvider<LanguageNotifier, LanguageState>(
  LanguageNotifier.new,
);
