import 'package:flutter/material.dart';

class SizeReportingWidget extends StatefulWidget {
  const SizeReportingWidget({
    super.key,
    required this.onSizeChange,
    required this.child,
  });
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size _oldSize = Size.zero;

  @override
  Widget build(final BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((final _) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    if (!mounted) {
      return;
    }
    final Size? size = context.size;
    if (_oldSize != size && size != null) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}
