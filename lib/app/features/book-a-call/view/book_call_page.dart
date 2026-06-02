import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/app_shadow.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/features/book-a-call/view/appointment_book_overview_page.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookCallPage extends StatefulWidget {
  const BookCallPage({super.key});

  @override
  State<BookCallPage> createState() => _BookCallPageState();
}

class _BookCallPageState extends State<BookCallPage> {
  int _selectedCallType = 0;

  DateTime _focusedMonth = DateTime(2026, 4);
  DateTime? _selectedDate = DateTime(2026, 4, 29);
  String? _selectedTime = "11:30 AM";

  // Unavailable (greyed out) times
  final List<String> _unavailableTimes = ["09:30 AM", "10:30 AM", "02:30 PM"];

  // All time slots
  final List<String> _timeSlots = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
  ];

  // ─── Calendar helpers ───────────────────────────────
  List<DateTime?> _buildCalendarDays(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final startWeekday = firstDay.weekday % 7; // Sun=0

    final List<DateTime?> days = List<DateTime?>.generate(
      startWeekday,
      (_) => null,
      growable: true,
    );

    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    return days;
  }

  String _monthLabel(DateTime dt) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return "${months[dt.month - 1]} ${dt.year}";
  }

  String _dayLabel(DateTime? date) {
    if (date == null) return "";
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return "${days[date.weekday % 7]}, ${months[date.month - 1]} ${date.day}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,

      appBar: CustomAppBar(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),

            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _yourCashManager(),
                    SizedBox(height: 20),

                    _callType(),
                    SizedBox(height: 20),

                    _selectDate(),

                    SizedBox(height: 20),

                    // ── Time Slots Card ──
                    _availableTimeSlot(),
                    SizedBox(height: 20),

                    _addNotes(),

                    SizedBox(height: 20),

                    // ── Appointment Summary Card ──
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: AppShadow.soft,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Calendar icon box
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFFBEAE8),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Color(0xFFE0DBD8),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.calendar_month_outlined,
                              size: 20,
                              color: Color(0xFFA41F13),
                            ),
                          ),

                          SizedBox(width: 12),

                          // Date & time info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Thu, April 30, 2026",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF292F36),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "11:30 AM · Video Call",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF6A6460),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Change button
                          GestureDetector(
                            onTap: () {
                              // Handle change
                            },
                            child: Text(
                              "Change",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFA41F13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14),

                    // ── Reminder note ──
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          size: 16,
                          color: Color(0xFF9A9490),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "A reminder will be sent to your registered email 30 minutes before the appointment.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF9A9490),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),

            _buildContinueButton(
             
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return  Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFA41F13), Color(0xFF7A1710)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA41F13).withValues(alpha: 0.30),
              offset: const Offset(0, 4),
              blurRadius: 24,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
                 Get.to(() => AppointmentBookOverviewPage());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icon/star.svg'),
                SizedBox(width: 6),
                Text(
                  'Confirm Appointment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }

  Widget _addNotes() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadow.soft,
        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          RichText(
            text: TextSpan(
              text: "ADD A NOTE ",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6A6460),
                letterSpacing: 0.8,
              ),
              children: [
                TextSpan(
                  text: "(optional)",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9A9490),
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Text field
          TextField(
            maxLines: 4,
            style: TextStyle(fontSize: 13, color: Color(0xFF292F36)),

            decoration: InputDecoration(
              hintText: "Tell your advisor what you'd like to discuss...",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color(0xFF9A9490),
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Color(0xFFFAF5F1),
              contentPadding: EdgeInsets.all(14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFE0DBD8), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFA41F13), width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _availableTimeSlot() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.soft,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AVAILABLE TIMES",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 12),
          Text(
            _selectedDate != null ? _dayLabel(_selectedDate) : "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6A6460),
            ),
          ),
          SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _timeSlots.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.6,
            ),
            itemBuilder: (context, index) {
              final time = _timeSlots[index];
              final isUnavailable = _unavailableTimes.contains(time);
              final isSelected = _selectedTime == time;

              return GestureDetector(
                onTap: isUnavailable
                    ? null
                    : () => setState(() => _selectedTime = time),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFFA41F13) : Color(0xFFFAF5F1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? Color(0xFFA41F13) : Color(0xFFE0DBD8),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : isUnavailable
                            ? Color(0xFFC4BFBC)
                            : Color(0xFF292F36),
                        decoration: isUnavailable
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Color(0xFFCDC9C6),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _selectDate() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.soft,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SELECT DATE",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 12),

          // Month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month - 1,
                  );
                }),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF5F1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFE0DBD8)),
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    size: 16,
                    color: Color(0xFF292F36),
                  ),
                ),
              ),
              Text(
                _monthLabel(_focusedMonth),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF292F36),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month + 1,
                  );
                }),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF5F1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFE0DBD8)),
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Color(0xFF292F36),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Day headers
          Row(
            children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6A6460),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 8),

          // Calendar grid
          Builder(
            builder: (context) {
              final days = _buildCalendarDays(_focusedMonth);
              final rows = (days.length / 7).ceil();
              return Column(
                children: List.generate(rows, (rowIndex) {
                  return Row(
                    children: List.generate(7, (colIndex) {
                      final i = rowIndex * 7 + colIndex;
                      final day = i < days.length ? days[i] : null;
                      final isSelected =
                          day != null &&
                          _selectedDate != null &&
                          day.year == _selectedDate!.year &&
                          day.month == _selectedDate!.month &&
                          day.day == _selectedDate!.day;
                      final isToday =
                          day != null &&
                          day.day == 20 &&
                          day.month == _focusedMonth.month;
                      final isPast = day != null && day.day < 20;

                      return Expanded(
                        child: GestureDetector(
                          onTap: day != null && !isPast
                              ? () => setState(() => _selectedDate = day)
                              : null,
                          child: Container(
                            margin: EdgeInsets.all(2),
                            height: 39,
                            width: 39,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xFFA41F13)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              border: isToday && !isSelected
                                  ? Border.all(
                                      color: Color(0xFFA41F13),
                                      width: 1.5,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                day != null ? "${day.day}" : "",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected || isToday
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? Colors.white
                                      : isPast
                                      ? Color(0xFFCDC9C6)
                                      : Color(0xFF292F36),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _callType() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.soft,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            "CALL TYPE",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 0.8,
            ),
          ),

          SizedBox(height: 12),

          Row(
            children: [
              // Phone Call option
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedCallType = 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16, // Same vertical padding
                    ),
                    decoration: BoxDecoration(
                      color: _selectedCallType == 0
                          ? Color(0xFFFAF5F1)
                          : Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedCallType == 0
                            ? Color(0xFFA41F13)
                            : Color(0xFFE0DBD8),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFE0DBD8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('assets/icon/phone.svg'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              "Phone Call",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF292F36),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Direct call to your\n number",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9A9490),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12),

              // Live Chat option
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedCallType = 1);
                    Get.toNamed(AppRoutes.liveChat);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16, // Same vertical padding as Phone Call
                    ),
                    decoration: BoxDecoration(
                      color: _selectedCallType == 1
                          ? Color(0xFFFAF5F1)
                          : Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Same borderRadius
                      border: Border.all(
                        color: _selectedCallType == 1
                            ? Color(0xFFA41F13)
                            : Color(0xFFE0DBD8),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFE0DBD8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 20,
                            color: _selectedCallType == 1
                                ? Color(0xFFA41F13)
                                : Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              "Live Chat",
                              style: TextStyle(
                                fontSize: 12, // Same fontSize
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF292F36),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Text chat in-app",
                              style: TextStyle(
                                fontSize: 10, // Same fontSize
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9A9490),
                              ),
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _yourCashManager() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.soft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            "YOUR CASE MANAGER",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A6460),
              letterSpacing: 0.8,
            ),
          ),

          SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFA41F13), Color(0xFF7A1710)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withValues(alpha: 0.10),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: -2,
                    ),
                    BoxShadow(
                      color: Color(0xFF000000).withValues(alpha: 0.10),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "JM",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jordan Mitchell",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF292F36),
                              ),
                            ),

                            Text(
                              "Senior Loan Advisor",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6A6460),
                              ),
                            ),

                            SizedBox(height: 8),

                            // Stars + rating
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < 4 ? Icons.star : Icons.star_half,
                                      color: Color(0xFFFFB900),
                                      size: 14,
                                    );
                                  }),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "4.9 (312 reviews)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6A6460),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Specialises in",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6A6460),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFBEAE8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xFFFFCDD2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "Homeowner Loans",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFA41F13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 2),

                    // Role
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            alignment: Alignment.center,
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFE0DBD8), width: 1.08),
              boxShadow: AppShadow.soft,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Color(0xFF292F36),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book a Call',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF292F36),
              ),
            ),

            Text(
              'Schedule a call with Dragon Finance',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6A6460),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
