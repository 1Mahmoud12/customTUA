import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tua/core/component/buttons/custom_text_button.dart';
import 'package:tua/core/themes/colors.dart';
import 'package:tua/core/utils/extensions.dart';

class BeautifulDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime)? onDateSelected;
  final Color primaryColor;
  final Color accentColor;

  const BeautifulDatePicker({
    Key? key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.primaryColor = AppColors.primaryColor,
    this.accentColor = Colors.purpleAccent,
  }) : super(key: key);

  @override
  State<BeautifulDatePicker> createState() => _BeautifulDatePickerState();
}

class _BeautifulDatePickerState extends State<BeautifulDatePicker> with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime.now();
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
    displayedMonth = DateTime(selectedDate.year, selectedDate.month);

    _slideController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _fadeController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  List<String> get monthNames => [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  List<String> get dayNames => ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];

  void _changeMonth(int direction) async {
    await _slideController.forward();
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + direction);
    });
    _slideController.reset();
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [widget.primaryColor, widget.accentColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderButton(icon: Icons.chevron_left, onTap: () => _changeMonth(-1)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(monthNames[displayedMonth.month - 1].tr(), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(displayedMonth.year.toString(), style: TextStyle(color: Colors.white.withAlpha((0.8 * 255).toInt()), fontSize: 16)),
            ],
          ),
          _buildHeaderButton(icon: Icons.chevron_right, onTap: () => _changeMonth(1)),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white.withAlpha((0.2 * 255).toInt()), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildDayHeaders() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children:
            dayNames.map((day) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Center(
                    child: FittedBox(child: Text(day.tr(), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 12))),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month);
    final lastDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;

    final List<Widget> dayWidgets = [];

    // Empty cells for days before the first day of the month
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(displayedMonth.year, displayedMonth.month, day);
      dayWidgets.add(_buildDayCell(date));
    }

    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.count(shrinkWrap: true, crossAxisCount: 7, children: dayWidgets),
      ),
    );
  }

  Widget _buildDayCell(DateTime date) {
    final isSelected = _isSameDay(date, selectedDate);
    final isToday = _isSameDay(date, DateTime.now());
    final isDisabled = widget.firstDate != null && date.isBefore(widget.firstDate!) || widget.lastDate != null && date.isAfter(widget.lastDate!);

    return GestureDetector(
      onTap: isDisabled ? null : () => _selectDate(date),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? widget.primaryColor
                  : isToday
                  ? widget.accentColor.withAlpha((0.3 * 255).toInt())
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isToday && !isSelected ? Border.all(color: widget.primaryColor, width: 2) : null,
        ),
        child: Center(
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color:
                  isSelected
                      ? Colors.white
                      : isDisabled
                      ? Colors.grey[400]
                      : isToday
                      ? widget.primaryColor
                      : Colors.black87,
              fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected?.call(date);
  }

  Widget _buildSelectedDateInfo() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: widget.primaryColor.withAlpha((0.1 * 255).toInt()), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.calendar_today, color: widget.primaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selected Date'.tr(), style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(_formatDate(selectedDate), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
          ),
        ],
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
                widget.onDateSelected?.call(selectedDate);
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

  String _formatDate(DateTime date) {
    final dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    return '${dayNames[date.weekday - 1]}, ${monthNames[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        //    height: context.screenHeight * .65,
        width: context.screenWidth * .9,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.12 * 255).toInt()), blurRadius: 20, offset: const Offset(0, 10))],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                _buildDayHeaders(),
                _buildCalendarGrid(),
                _buildSelectedDateInfo(),
                _acceptCancelButtons(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
