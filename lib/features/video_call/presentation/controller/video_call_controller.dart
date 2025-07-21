import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/permissions_helper.dart';
import '../../../../core/secrets.dart';


class VideoCallController {
  late final StreamVideo streamVideo;
  late final Call call;

  Future<void> initialize() async {
    await PermissionsHelper.requestCameraAndMicPermissions();

    final userId = 'user-${const Uuid().v4()}';


    streamVideo = StreamVideo(
      Secrets.streamApiKey,
      user: User(
        info: UserInfo(
          id: userId,
          name: userId,
        ),
        type: UserType.guest,
      ),
    );

    call = streamVideo.makeCall(
      callType: StreamCallType.defaultType(),
      id: 'default_c97c8d60-3737-42fd-94d8-53bf139be902',
    );
  }

  Future<void> joinCall() async => await call.join();
  Future<void> leaveCall() async => await call.leave();
  void dispose() {
    call.end();
    streamVideo.dispose();
  }
}
