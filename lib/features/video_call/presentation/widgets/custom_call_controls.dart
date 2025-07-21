import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class CustomCallControls extends StatelessWidget {
  final Call call;
  final CallParticipantState localParticipant;
  final VoidCallback onLeave;

  const CustomCallControls({
    super.key,
    required this.call,
    required this.localParticipant,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return StreamCallControls(
      options: [
        ToggleCameraOption(call: call, localParticipant: localParticipant),
        ToggleMicrophoneOption(call: call, localParticipant: localParticipant),

        LeaveCallOption(call: call, onLeaveCallTap: onLeave),
      ],
    );
  }
}
