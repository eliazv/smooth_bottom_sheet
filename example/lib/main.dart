import 'package:flutter/material.dart';
import 'package:smooth_bottom_sheet/smooth_bottom_sheet.dart';

void main() {
  runApp(const SmoothBottomSheetExampleApp());
}

class SmoothBottomSheetExampleApp extends StatelessWidget {
  const SmoothBottomSheetExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'smooth_bottom_sheet example',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0EA5E9),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF7C3AED),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const _ExampleHomePage(),
    );
  }
}

class _ExampleHomePage extends StatefulWidget {
  const _ExampleHomePage();

  @override
  State<_ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<_ExampleHomePage> {
  final SmoothBottomSheetController _controller = SmoothBottomSheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDefaultSheet() {
    showSmoothBottomSheet<void>(
      context: context,
      title: 'Smooth sheet',
      subtitle: 'Default adaptive style',
      child: const Text(
        'This is the default smooth bottom sheet. '
        'Use it for settings, confirmations and action menus.',
      ),
    );
  }

  void _openCustomizedSheet() {
    showSmoothBottomSheet<void>(
      context: context,
      title: 'Custom style',
      subtitle: 'Theme + layout + animation',
      controller: _controller,
      theme: SmoothBottomSheetTheme.dark().copyWith(
        startColor: const Color(0xFF1E1B4B),
        endColor: const Color(0xFF0B1025),
        borderColor: const Color(0x66A78BFA),
      ),
      layout: const SmoothBottomSheetLayout(borderRadius: 40, maxWidth: 560),
      animation: const SmoothBottomSheetAnimation(
        duration: Duration(milliseconds: 420),
        beginOffset: Offset(0, 0.14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This sheet can be closed from inside or by controller.',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => _controller.close(),
            child: const Text('Close with controller'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('smooth_bottom_sheet example')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.tonal(
                  onPressed: _openDefaultSheet,
                  child: const Text('Open default sheet'),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _openCustomizedSheet,
                  child: const Text('Open customized sheet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
