import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class SignToTextScreen02 extends StatefulWidget {
  const SignToTextScreen02({super.key});

  @override
  _SignToTextScreen02State createState() => _SignToTextScreen02State();
}

class _SignToTextScreen02State extends State<SignToTextScreen02> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  bool isCameraOn = false; // Track camera status

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Fetch the list of available cameras
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      // Initialize the camera controller for the first available camera
      _cameraController = CameraController(
        cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController!.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    }
  }

  // Method to start or stop the camera
  void _toggleCamera() {
    if (isCameraOn) {
      // Dispose of the camera controller and mark camera as off
      _cameraController?.dispose();
      setState(() {
        isCameraOn = false;
        isCameraInitialized = false; // Mark the camera as not initialized
      });
    } else {
      // Re-initialize the camera if disposed
      _initializeCamera();
      setState(() {
        isCameraOn = true;
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the camera controller when the widget is disposed
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign To Text Translate',
          style: appbartitlestyle,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),

          // Camera preview container
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: boxborder,
                  width: 1.8,
                ),
              ),
              child: isCameraOn
                  ? isCameraInitialized
                      ? CameraPreview(_cameraController!)
                      : const Center(child: CircularProgressIndicator())
                  : const Center(child: Text('Camera is off')),
            ),
          ),

          const SizedBox(height: 30),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: 130,
                child: customButton(
                  icon: Icons.gesture,
                  label: 'Start Translation',
                  bgColor: Colors.blue.shade50,
                  labelStyle: const TextStyle(
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                  ),
                  border:
                      BorderSide(color: const Color(0xFF0D47A1), width: 1.5),
                  onPressed: () {
                    // Start translation logic here
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: 130,
                child: customButton(
                  icon: Icons.camera_alt,
                  label: isCameraOn ? 'Turn Off Camera' : 'Camera',
                  bgColor: Colors.blue.shade50,
                  labelStyle: const TextStyle(
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                  ),
                  border: BorderSide(color: Colors.blue.shade900, width: 1.5),
                  onPressed: _toggleCamera,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Text display container with share/download icons
          Stack(
            children: [
              Container(
                width: 360,
                height: 80,
                decoration: BoxDecoration(
                  color: boxfilcolor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: boxborder,
                    width: 1.8,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Text',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: texticonColor,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.download, color: texticonColor),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: texticonColor),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget customButton({
  required IconData icon,
  required String label,
  required Color bgColor,
  TextStyle? labelStyle,
  VoidCallback? onPressed,
  BorderSide? border,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon:
        Icon(icon, color: labelStyle?.color ?? Colors.blue), // match icon color
    label: Text(
      label,
      style: labelStyle ?? const TextStyle(color: Colors.blue),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: border ?? const BorderSide(color: Colors.blue),
      ),
    ),
  );
}
