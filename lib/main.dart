import 'package:flutter/material.dart';

import 'features/video_call/presentation/screens/viedio_call_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  const VideoCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guitara Video Call',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VideoCallScreen(),
    );
  }
}
