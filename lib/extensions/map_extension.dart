// extension MapExtension<K,V> on Map<K, V> {
//   Iterable<R> flatMap<R>(final R Function(MapEntry<K,V> it) block) {
//     return entries.map(block);
//   }
// }

bool isNullOrEmpty(Map<dynamic, dynamic>? it) => it?.isEmpty ?? true;

bool isNotEmpty(Map<dynamic, dynamic>? it) => it?.isNotEmpty ?? false;
