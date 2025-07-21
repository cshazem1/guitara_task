import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import '../controller/video_call_controller.dart';
import '../widgets/custom_call_controls.dart';


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final VideoCallController _controller = VideoCallController();
  bool _isInitialized = false;
  bool _isJoining = false;
  bool _isInCall = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      await _controller.initialize();
      setState(() => _isInitialized = true);
      await _joinCall();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _joinCall() async {
    if (_isJoining || _isInCall) return;
    setState(() => _isJoining = true);

    try {
      await _controller.joinCall();
      setState(() {
        _isInCall = true;
        _isJoining = false;
      });
    } catch (e) {
      debugPrint('Join error: $e');
      setState(() => _isJoining = false);
    }
  }

  Future<void> _leaveCall() async {
    await _controller.leaveCall();
    setState(() => _isInCall = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_isInCall) {
      return Scaffold(
        body: StreamCallContainer(

          call: _controller.call,
          callContentBuilder: (context, call, callState) {
            return StreamCallContent(
              call: call,
              callState: callState,
              callControlsBuilder: (context, call, callState) {
                return CustomCallControls(
                  call: call,
                  localParticipant: callState.localParticipant!,
                  onLeave: _leaveCall,
                );
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Guitara Video Call')),
      body: Center(
        child: _isJoining
            ? const CircularProgressIndicator()
            : const Text('loading...'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
