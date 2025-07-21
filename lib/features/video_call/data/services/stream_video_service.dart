
import 'package:stream_video/stream_video.dart';


class VideoService {
  final StreamVideo client;
  Call? call;

  VideoService(this.client);

  Future<void> connectToTestRoom() async {
    call = client.makeCall(
      callType: StreamCallType(),
      id: 'test-room', // Fixed room ID
    );

    await call!.getOrCreate();
    await call!.join();
  }

  void endCall() {
    call?.leave();
    call = null;
  }
}