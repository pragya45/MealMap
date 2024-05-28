import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //HiveService().deleteHive();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
