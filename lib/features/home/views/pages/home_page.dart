import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goddb_task/features/home/views/widgets/bottom_navigation_bar_widget.dart';
import 'package:goddb_task/features/home/views/widgets/filters_card.dart';
import '../../../tasks/cubits/task_cubit.dart';
import '../widgets/slidable_cards.dart';
import '../../../tasks/views/widgets/tasks_widget.dart';
import '../widgets/welcoming_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF2F5FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          welcome_widget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FiltersCard("My Tasks",TaskFilter.myTask),
              SizedBox(width: 10.w,),
              FiltersCard("In Progress",TaskFilter.inProgress),
              SizedBox(width: 10.w,),
              FiltersCard("Completed",TaskFilter.completed),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SlidableCards(),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Progress",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: 10.h,
          ),
          TasksWidget(),

        ]),
      ),
      bottomNavigationBar: BottomNavigationBarWidget()
    ));
  }
}
