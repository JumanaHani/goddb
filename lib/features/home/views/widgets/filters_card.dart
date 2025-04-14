import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tasks/cubits/task_cubit.dart';
import '../../../tasks/cubits/task_state.dart';

class FiltersCard extends StatelessWidget {
  final String cardTitle;
  final TaskFilter filter;

  const FiltersCard(this.cardTitle, this.filter, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TaskCubit>().setFilter(filter);
      },
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          bool isSelected = state is TaskLoaded && state.filter == filter;

          return Container(
            height: 70.h,
            width: 156.w,
            decoration: BoxDecoration(
                color: isSelected ? Colors.white : Color(0xffE5EAFC),
                borderRadius: BorderRadius.circular(75)),
            child: Center(
              child: Text(cardTitle),
            ),
          );
        },
      ),
    );
  }
}
