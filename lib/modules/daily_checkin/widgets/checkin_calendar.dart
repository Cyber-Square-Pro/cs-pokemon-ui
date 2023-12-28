import 'package:app/shared/models/daily_checkin_model.dart';
import 'package:app/theme/app_theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckinCalendar extends StatelessWidget {
  const CheckinCalendar(
    this.data, {
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final List<History> data;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return TableCalendar(
      calendarStyle: _calStyle(context),
      headerStyle: _headerStyle(context),
      weekNumbersVisible: false,
      focusedDay: focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,

      // Builders
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, currentDate, events) {
          final History? status = data.firstWhereOrNull(
            (element) =>
                (element.createdAt.year == currentDate.year) &&
                (element.createdAt.month == currentDate.month) &&
                (element.createdAt.day == currentDate.day),
          );
          if (status != null) {
            return status.isCheckedIn == true
                ? Container(
                    decoration:
                        _markerDecoration(context, Colors.teal.shade400),
                    width: 40.w,
                    height: 5.h,
                  )
                : Container(
                    decoration:
                        _markerDecoration(context, Colors.red.withOpacity(0.5)),
                    width: 40.w,
                    height: 5.h,
                  );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

_markerDecoration(BuildContext context, Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(2.5),
  );
}

CalendarStyle _calStyle(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return CalendarStyle(
    tablePadding: EdgeInsets.only(
      top: 10.h,
    ),
    weekendTextStyle: TextStyle(
      color: theme.error.withOpacity(0.75),
    ),
    selectedDecoration: BoxDecoration(
      color: theme.primary,
    ),
    disabledTextStyle: TextStyle(
      color: theme.onBackground.withOpacity(0.25),
    ),
    todayDecoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    markerDecoration: BoxDecoration(
      color: theme.primary.withOpacity(0.25),
      borderRadius: BorderRadius.circular(10.r),
    ),
    todayTextStyle: TextStyle(
      color: theme.onBackground,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    ),
  );
}

HeaderStyle _headerStyle(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return HeaderStyle(
    decoration: BoxDecoration(
      color: mediumBlue,
      borderRadius: BorderRadius.circular(15.r),
    ),
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: theme.background,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      height: 1,
    ),
    headerPadding: EdgeInsets.zero,
    leftChevronIcon: Icon(
      CupertinoIcons.left_chevron,
      color: theme.onPrimary,
    ),
    rightChevronIcon: Icon(
      CupertinoIcons.right_chevron,
      color: theme.onPrimary,
    ),
    formatButtonVisible: false,
  );
}