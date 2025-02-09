import 'package:flutter_riverpod/flutter_riverpod.dart';

final textsRepositoryProvider = StateProvider.autoDispose<List<String>>((ref) {
  return ['0923', '0820', '8203', '099', '20', '30928', '659929'];
});
