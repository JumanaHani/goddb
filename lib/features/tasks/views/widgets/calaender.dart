import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${DateFormat('MMM').format(_focusedDay)}, ${_focusedDay.year}',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/AddTask');
                },
                child: Container(
                    width: 171.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF9C2CF3), // #9C2CF3
                          Color(0xFF3A49F9), // #3A49F9
                        ],
                        stops: [
                          -0.1349,
                          1.0975
                        ], // match CSS percentages (optional)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40E2E2E2), // #E2E2E240 (25% opacity)
                          offset: Offset(17, 26), // x: 17px, y: 26px
                          blurRadius: 25, // blur
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(75), // optional
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        Text(
                          'Add Task',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )
                      ],
                    )
                    // your content here
                    ),
              )
            ],
          ),
          SizedBox(height: 80.h),
          Container(height: 123.h,
            child: TableCalendar(
              calendarFormat: CalendarFormat.week,
              firstDay: DateTime.utc(2010),
              lastDay: DateTime.utc(2030),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              headerVisible: false,
              daysOfWeekVisible: false,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return Container(child: _buildDayCell(day, false));
                },
                selectedBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day, true);
                },
                todayBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day, false, isToday: true);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDayCell(DateTime day, bool isSelected, {bool isToday = false}) {
  final dayName = DateFormat('EEE').format(day); // e.g. Tue
  final dayNumber = DateFormat('d').format(day); // e.g. 15

  return Container(
   // padding: EdgeInsets.all(5),
  //  margin: EdgeInsets.all(6.w),
    decoration: BoxDecoration(
      color: isSelected
          ? Colors.deepPurple.withOpacity(0.2)
          : isToday
              ? Colors.deepPurple.withOpacity(0.05)
              : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dayName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23.19.sp,
              fontFamily: 'Poppins',
              color: isSelected ? Colors.deepPurple : Colors.black,
            ),
          ),
          SizedBox(height:2),
          Text(
            dayNumber,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 23.19.sp,
              fontFamily: 'Poppins',
              color: isSelected ? Colors.deepPurple : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
