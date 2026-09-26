import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});
  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      title: const Text('Scan vault tag'),
      actions: [
        IconButton(
          icon: const Icon(Icons.flash_on_rounded),
          tooltip: 'Toggle torch',
          onPressed: _controller.toggleTorch,
        ),
        IconButton(
          icon: const Icon(Icons.cameraswitch_rounded),
          tooltip: 'Switch camera',
          onPressed: _controller.switchCamera,
        ),
      ],
    ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(controller: _controller, onDetect: _onDetect),
        CustomPaint(painter: _ScannerOverlayPainter()),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Align a CampusLost QR tag within the frame',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  void _onDetect(BarcodeCapture capture) {
    if (_handled || capture.barcodes.isEmpty) return;
    final value = capture.barcodes.first.rawValue;
    const prefix = 'campuslost://item/';
    if (value?.startsWith(prefix) != true) return;
    _handled = true;
    _controller.stop();
    context.go('/item/${value!.substring(prefix.length)}');
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final box = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: 255,
      height: 255,
    );
    final overlay = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addRRect(RRect.fromRectAndRadius(box, const Radius.circular(20)));
    canvas.drawPath(
      overlay,
      Paint()
        ..color = Colors.black54
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(box, const Radius.circular(20)),
      Paint()
        ..color = const Color(0xFF34D399)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
