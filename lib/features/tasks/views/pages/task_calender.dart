import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goddb_task/core/di/injection_container.dart';
import 'package:goddb_task/features/home/views/widgets/bottom_navigation_bar_widget.dart';
import 'package:goddb_task/features/tasks/views/widgets/tasks_widget.dart';

import '../../../../core/utils/configs/theme/app_colors.dart';
import '../../cubits/task_cubit.dart';
import '../widgets/calaender.dart';

class TaskCalendar extends StatelessWidget {
  const TaskCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().setFilter(TaskFilter.myTask);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF2F5FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 395.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: CalendarPage(),
          ),
          SizedBox(
            height: 50.h,
          ),
          Expanded(//height: 500,

              child: Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 52.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tasks",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TasksWidget(),


                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    ));
  }
}
