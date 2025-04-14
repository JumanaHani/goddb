import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/task_cubit.dart';
import '../../cubits/task_state.dart';
import '../../models/task.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasks();
  }
  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            final tasks = state.tasks;
            if(tasks.length==0) {
              return Center(child: Padding(
              padding:  EdgeInsets.all(100.h),
              child: Text("No Tasks",style: TextStyle(fontSize: 70.sp),),
            ));
            }
            return  Expanded(//height: 150,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {

                  final task = tasks[index];

                  return Container(width: 620.w,height: 122.h,margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(  color: Colors.white,    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000), // equivalent to #00000005 (very light black)
                        offset: Offset(0, -7),    // x: 0px, y: -7px (shadow going upward)
                        blurRadius: 23,           // blur
                        spreadRadius: 0,          // spread
                      ),
                    ],borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ListTile(
                      leading: Icon(Icons.table_view_sharp),
                      title: Text(task.name,style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 22.42.sp,color: Color(0xff242736)),),
                      subtitle: Text(task.description,style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16.48.sp,color: Color(0xffAEAEB3)),),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded,color: Color(0xffD8DEF3),)),

                    ),
                  );
                },
              ),
            );
          } else if (state is TaskInitial) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('No tasks found.'));
          }
        },
      );

      Container(width: 620.w,height: 122.h,margin: EdgeInsets.only(bottom: 20.h),
  decoration: BoxDecoration(  color: Colors.white,    boxShadow: [
    BoxShadow(
      color: Color(0x05000000), // equivalent to #00000005 (very light black)
      offset: Offset(0, -7),    // x: 0px, y: -7px (shadow going upward)
      blurRadius: 23,           // blur
      spreadRadius: 0,          // spread
    ),
  ],borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        leading: Icon(Icons.table_view_sharp),
        title: Text('Design Changes',style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 22.42.sp,color: Color(0xff242736)),),
        subtitle: Text('2 Days ago',style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16.48.sp,color: Color(0xffAEAEB3)),),
        trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded,color: Color(0xffD8DEF3),)),
      ),
    );
  }
}
