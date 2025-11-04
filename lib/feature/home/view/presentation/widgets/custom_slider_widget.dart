import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final bool canControl;
  final ValueChanged<double>? onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Widget? prefix;
  final Widget? suffix;
  final String? label;
  final bool showPercentage;
  final double height;
  final double thumbRadius;
  final BorderRadius? borderRadius;

  const CustomSlider({
    Key? key,
    required this.value,
    this.min = 0.0,
    this.max = 100.0,
    this.canControl = true,
    this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.thumbColor = Colors.white,
    this.prefix,
    this.suffix,
    this.label,
    this.showPercentage = false,
    this.height = 6.0,
    this.thumbRadius = 10.0,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentValue;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _currentValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(padding: const EdgeInsets.only(bottom: 8.0), child: Text(widget.label!, style: const TextStyle(fontWeight: FontWeight.bold))),
        Row(
          children: [
            if (widget.prefix != null) Padding(padding: const EdgeInsets.only(right: 8.0), child: widget.prefix),
            Expanded(
              child: GestureDetector(
                onHorizontalDragStart:
                    widget.canControl && widget.onChanged != null
                        ? (_) {
                          setState(() {
                            _isDragging = true;
                          });
                        }
                        : null,
                onHorizontalDragUpdate:
                    widget.canControl && widget.onChanged != null
                        ? (details) {
                          final RenderBox box = context.findRenderObject()! as RenderBox;
                          final double width = box.size.width;
                          final double dx = details.localPosition.dx.clamp(0, width);
                          final double newValue = widget.min + (widget.max - widget.min) * (dx / width);

                          setState(() {
                            _currentValue = newValue.clamp(widget.min, widget.max);
                          });

                          widget.onChanged?.call(_currentValue);
                        }
                        : null,
                onHorizontalDragEnd:
                    widget.canControl && widget.onChanged != null
                        ? (_) {
                          setState(() {
                            _isDragging = false;
                          });
                        }
                        : null,
                onTapDown:
                    widget.canControl && widget.onChanged != null
                        ? (details) {
                          final RenderBox box = context.findRenderObject()! as RenderBox;
                          final double width = box.size.width;
                          final double dx = details.localPosition.dx.clamp(0, width);
                          final double newValue = widget.min + (widget.max - widget.min) * (dx / width);

                          setState(() {
                            _currentValue = newValue.clamp(widget.min, widget.max);
                          });

                          widget.onChanged?.call(_currentValue);
                        }
                        : null,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Inactive track
                    Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.inactiveColor,
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
                      ),
                    ),
                    // Active track
                    FractionallySizedBox(
                      widthFactor: (_currentValue - widget.min) / (widget.max - widget.min),
                      child: Container(
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: widget.activeColor,
                          borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
                        ),
                      ),
                    ),
                    // Thumb
                    if (widget.canControl)
                      Positioned(
                        left:
                            (_currentValue - widget.min) /
                            (widget.max - widget.min) *
                            (MediaQuery.of(context).size.width - (widget.prefix != null ? 40 : 0) - (widget.suffix != null ? 40 : 0)),
                        child: Container(
                          width: widget.thumbRadius * 2,
                          height: widget.thumbRadius * 2,
                          decoration: BoxDecoration(
                            color: widget.thumbColor,
                            shape: BoxShape.circle,
                            boxShadow:
                                _isDragging
                                    ? [BoxShadow(color: Colors.black.withAlpha((0.3 * 255).toInt()), blurRadius: 5, offset: const Offset(0, 2))]
                                    : null,
                          ),
                        ),
                      ),
                    if (widget.showPercentage)
                      Positioned(
                        right: 8,
                        child: Text(
                          '${((_currentValue - widget.min) / (widget.max - widget.min) * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.suffix != null) Padding(padding: const EdgeInsets.only(left: 8.0), child: widget.suffix),
          ],
        ),
      ],
    );
  }
}
