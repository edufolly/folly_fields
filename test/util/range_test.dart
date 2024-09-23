import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/range.dart';

///
///
///
void main() {
  group('Range', () {
    test('Test 0..5', () {
      Range range = const Range(0, 5);
      expect(range.first, 0);
      expect(range.last, 5);
      expect(range.length, 6);
      expect(range.contains(-1), false);
      expect(range.contains(0), true);
      expect(range.contains(1), true);
      expect(range.contains(4), true);
      expect(range.contains(5), true);
      expect(range.contains(6), false);
      expect(range.toList(), <int>[0, 1, 2, 3, 4, 5]);
      expect(range.intersects(const Range(-10, -1)), false);
      expect(range.intersects(const Range(-10, 0)), true);
      expect(range.intersects(const Range(-10, 1)), true);
      expect(range.intersects(const Range(-10, 4)), true);
      expect(range.intersects(const Range(-10, 5)), true);
      expect(range.intersects(const Range(-10, 10)), true);
      expect(range.intersects(const Range(1, 4)), true);
      expect(range.intersects(const Range(6, 10)), false);
      expect(range.intersects(const Range(5, 10)), true);
      expect(range.intersects(const Range(4, 10)), true);
      expect(range.intersects(const Range(1, 10)), true);
      expect(range.intersects(const Range(0, 10)), true);
      expect(range.toString(), 'Range(0, 5)');
      expect(range.hashCode, 968375619);
      expect(range == const Range(0, 5), true);
      expect(range == const Range.exclusive(0, 5), false);
      expect(range.copyWith(first: 1, last: 6), const Range(1, 6));
    });

    test('Constructor assert error', () {
      expect(() => Range(3, 2), throwsAssertionError);
    });
  });
}
