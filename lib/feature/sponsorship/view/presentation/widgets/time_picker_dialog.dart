import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart' show CustomTextButton;
import 'package:tua/core/themes/colors.dart';

class BeautifulTimePicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final Function(TimeOfDay)? onTimeSelected;
  final Color primaryColor;
  final Color accentColor;
  final bool is24HourFormat;

  const BeautifulTimePicker({
    Key? key,
    this.initialTime,
    this.onTimeSelected,
    this.primaryColor = AppColors.primaryColor,
    this.accentColor = Colors.purpleAccent,
    this.is24HourFormat = false,
  }) : super(key: key);

  @override
  State<BeautifulTimePicker> createState() => _BeautifulTimePickerState();
}

class _BeautifulTimePickerState extends State<BeautifulTimePicker> with TickerProviderStateMixin {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isSelectingHour = true;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? TimeOfDay.now();

    _fadeController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _scaleController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut));

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  String get _period => selectedTime.period == DayPeriod.am ? 'AM' : 'PM';

  void _selectTime(int value) {
    setState(() {
      if (isSelectingHour) {
        int hour = value;
        if (!widget.is24HourFormat && _period == 'PM' && hour != 12) {
          hour += 12;
        } else if (!widget.is24HourFormat && _period == 'AM' && hour == 12) {
          hour = 0;
        }
        selectedTime = TimeOfDay(hour: hour, minute: selectedTime.minute);
      } else {
        selectedTime = TimeOfDay(hour: selectedTime.hour, minute: value);
      }
    });
    widget.onTimeSelected?.call(selectedTime);
  }

  void _togglePeriod() {
    if (!widget.is24HourFormat) {
      setState(() {
        final int newHour = selectedTime.hour >= 12 ? selectedTime.hour - 12 : selectedTime.hour + 12;
        selectedTime = TimeOfDay(hour: newHour, minute: selectedTime.minute);
      });
      widget.onTimeSelected?.call(selectedTime);
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [widget.primaryColor, widget.accentColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Text('select_time'.tr(), style: TextStyle(color: Colors.white.withAlpha((0.8 * 255).toInt()), fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeUnit(
                value:
                    widget.is24HourFormat
                        ? selectedTime.hour.toString().padLeft(2, '0')
                        : (selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod).toString().padLeft(2, '0'),
                isSelected: isSelectingHour,
                onTap: () => setState(() => isSelectingHour = true),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(':', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w300)),
              ),
              _buildTimeUnit(
                value: selectedTime.minute.toString().padLeft(2, '0'),
                isSelected: !isSelectingHour,
                onTap: () => setState(() => isSelectingHour = false),
              ),
              if (!widget.is24HourFormat) ...[
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _togglePeriod,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white.withAlpha((0.2 * 255).toInt()), borderRadius: BorderRadius.circular(8)),
                    child: Text(_period, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit({required String value, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withAlpha((0.2 * 255).toInt()) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(value, style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: isSelected ? FontWeight.bold : FontWeight.w300)),
      ),
    );
  }

  Widget _buildClockFace() {
    return Container(
      width: 280,
      height: 280,
      margin: const EdgeInsets.all(24),
      child: Stack(
        children: [
          // Clock circle background
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[50], border: Border.all(color: Colors.grey[200]!, width: 2)),
          ),
          // Numbers
          ...List.generate(12, (index) => _buildClockNumber(index)),
          // Clock hands
          _buildClockHand(),
          // Center dot
          Center(child: Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: widget.primaryColor))),
        ],
      ),
    );
  }

  Widget _buildClockNumber(int index) {
    final angle = (index * 30 - 90) * math.pi / 180;
    const radius = 110.0;
    final x = radius * math.cos(angle);
    final y = radius * math.sin(angle);

    int displayValue;
    bool isCurrentValue;

    if (isSelectingHour) {
      displayValue = index == 0 ? 12 : index;
      final int currentHour =
          widget.is24HourFormat
              ? selectedTime.hour == 0
                  ? 12
                  : (selectedTime.hour > 12 ? selectedTime.hour - 12 : selectedTime.hour)
              : (selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod);
      isCurrentValue = displayValue == currentHour;
    } else {
      displayValue = index * 5;
      isCurrentValue = displayValue == selectedTime.minute;
    }

    return Positioned(
      left: 140 + x - 20,
      top: 140 + y - 20,
      child: GestureDetector(
        onTap: () => _selectTime(isSelectingHour ? displayValue : displayValue),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, color: isCurrentValue ? widget.primaryColor : Colors.transparent),
          child: Center(
            child: Text(
              displayValue.toString().padLeft(2, '0'),
              style: TextStyle(
                color: isCurrentValue ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: isCurrentValue ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClockHand() {
    double angle;
    double length;

    if (isSelectingHour) {
      // For hour hand - convert to 12-hour format for positioning
      final int displayHour =
          widget.is24HourFormat
              ? (selectedTime.hour == 0 ? 12 : (selectedTime.hour > 12 ? selectedTime.hour - 12 : selectedTime.hour))
              : (selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod);

      // Calculate angle: each hour is 30 degrees, starting from 12 o'clock (top)
      angle = ((displayHour % 12) * 30 - 90) * math.pi / 180;
      length = 80.0;
    } else {
      // For minute hand - each minute is 6 degrees
      angle = (selectedTime.minute * 6 - 90) * math.pi / 180;
      length = 100.0;
    }

    return Positioned(
      left: 140,
      top: 140,
      child: CustomPaint(painter: ClockHandPainter(angle: angle, length: length, color: widget.primaryColor, thickness: 3.0)),
    );
  }

  Widget _buildModeSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isSelectingHour = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: isSelectingHour ? widget.primaryColor : Colors.transparent, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time, color: isSelectingHour ? Colors.white : Colors.grey[600], size: 20),
                    const SizedBox(width: 8),
                    Text('hour'.tr(), style: TextStyle(color: isSelectingHour ? Colors.white : Colors.grey[600], fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isSelectingHour = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isSelectingHour ? widget.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.schedule, color: !isSelectingHour ? Colors.white : Colors.grey[600], size: 20),
                    const SizedBox(width: 8),
                    Text('minute'.tr(), style: TextStyle(color: !isSelectingHour ? Colors.white : Colors.grey[600], fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedTimeInfo() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: widget.primaryColor.withAlpha((0.1 * 255).toInt()), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.access_time, color: widget.primaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('selected_time'.tr(), style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(_formatTime(selectedTime), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    if (widget.is24HourFormat) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.12 * 255).toInt()), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  _buildModeSelector(),
                  _buildClockFace(),
                  _buildSelectedTimeInfo(),
                  _acceptCancelButtons(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _acceptCancelButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextButton(
              onPress: () {
                widget.onTimeSelected?.call(selectedTime);
                Navigator.pop(context);
              },
              backgroundColor: AppColors.primaryColor,
              colorText: AppColors.white,
              borderRadius: 10,
              borderColor: Colors.transparent,
              childText: 'select'.tr(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomTextButton(
              onPress: () {
                Navigator.pop(context);
              },
              borderRadius: 10,
              childText: 'cancel'.tr(),
              backgroundColor: Colors.transparent,
              colorText: AppColors.primaryColor,
              borderColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for precise clock hand
class ClockHandPainter extends CustomPainter {
  final double angle;
  final double length;
  final Color color;
  final double thickness;

  ClockHandPainter({required this.angle, required this.length, required this.color, required this.thickness});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness
          ..strokeCap = StrokeCap.round;

    final endX = length * math.cos(angle);
    final endY = length * math.sin(angle);

    canvas.drawLine(Offset.zero, Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(ClockHandPainter oldDelegate) {
    return oldDelegate.angle != angle || oldDelegate.length != length || oldDelegate.color != color || oldDelegate.thickness != thickness;
  }
}
