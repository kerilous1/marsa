import 'package:flutter_test/flutter_test.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

void main() {
  test('verify receive_sharing_intent API', () {
    final instance = ReceiveSharingIntent.instance;
    const mediaType = SharedMediaType.text;
    const imgType = SharedMediaType.image;
    expect(mediaType, isNotNull);
    expect(imgType, isNotNull);
  });
}
