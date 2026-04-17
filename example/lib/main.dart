import 'package:flutter/material.dart';
import 'package:smooth_bottom_sheet/smooth_bottom_sheet.dart';

void main() {
  runApp(const SmoothBottomSheetExampleApp());
}

class SmoothBottomSheetExampleApp extends StatefulWidget {
  const SmoothBottomSheetExampleApp({super.key});

  @override
  State<SmoothBottomSheetExampleApp> createState() =>
      _SmoothBottomSheetExampleAppState();
}

class _SmoothBottomSheetExampleAppState
    extends State<SmoothBottomSheetExampleApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'smooth_bottom_sheet example',
      themeMode: _themeMode,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0EA5E9),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF7C3AED),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: _ExampleHomePage(
        onToggleTheme: _toggleTheme,
        themeMode: _themeMode,
      ),
    );
  }
}

class _ExampleHomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const _ExampleHomePage({
    required this.onToggleTheme,
    required this.themeMode,
  });

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
    final isDark = widget.themeMode == ThemeMode.dark;
    showSmoothBottomSheet<void>(
      context: context,
      title: 'Custom style',
      subtitle: 'Theme + layout + animation',
      controller: _controller,
      theme: (isDark ? SmoothBottomSheetTheme.dark() : SmoothBottomSheetTheme.light())
          .copyWith(
        startColor: isDark ? const Color(0xFF1E1B4B) : const Color(0xFFEEF2FF),
        endColor: isDark ? const Color(0xFF0B1025) : const Color(0xFFE0E7FF),
        borderColor: isDark ? const Color(0x66A78BFA) : const Color(0x336366F1),
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
          Text(
            'This sheet can be closed from inside or by controller.',
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
            ),
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

  void _openScrollableSheet() {
    showSmoothBottomSheet<void>(
      context: context,
      title: 'Scrollable sheet',
      subtitle: 'Long content, capped at 80% height',
      scrollable: true,
      showHandle: true,
      maxHeightFactor: 0.8,
      child: _LongContent(),
    );
  }

  void _openGradientHeaderSheet() {
    showSmoothBottomSheet<void>(
      context: context,
      title: 'Gradient header',
      subtitle: 'Content scrolls under the faded header',
      gradientHeader: true,
      showHandle: true,
      maxHeightFactor: 0.8,
      child: _LongContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('smooth_bottom_sheet'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Light mode' : 'Dark mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionLabel('Standard'),
                const SizedBox(height: 8),
                FilledButton.tonal(
                  onPressed: _openDefaultSheet,
                  child: const Text('Default sheet'),
                ),
                const SizedBox(height: 8),
                FilledButton.tonal(
                  onPressed: _openCustomizedSheet,
                  child: const Text('Customized (theme + controller)'),
                ),
                const SizedBox(height: 20),
                _SectionLabel('Scrollable content'),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _openScrollableSheet,
                  child: const Text('Scrollable — 80% height'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _openGradientHeaderSheet,
                  child: const Text('Gradient header — content scrolls under'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        letterSpacing: 1.2,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _LongContent extends StatelessWidget {
  const _LongContent();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 1; i <= 14; i++) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$i',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item $i',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Scroll up — watch this item slide under the gradient header.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (i < 14) const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
}
