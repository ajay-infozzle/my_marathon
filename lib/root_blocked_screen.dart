import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BlockReason { rooted, developerMode, other }

class RootBlockedScreen extends StatelessWidget {
  final BlockReason reason;

  const RootBlockedScreen({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    String title = 'Security Warning';
    String message = '';

    if (reason == BlockReason.rooted) {
      message = 'This app cannot run on a rooted or jailbroken device.\n'
          'Please use a secure device.';
    } else if (reason == BlockReason.developerMode) {
      message = 'Developer Mode is enabled.\n'
          'Please turn off Developer Mode to use this app.';
    }

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.block, color: Colors.red, size: 80),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text("Exit App"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
