import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../../globals.dart';
import '../../../tasks/cubits/task_cubit.dart';
import '../../models/project.dart';

class SlidableCards extends StatefulWidget {
  @override
  _SlidableCardsState createState() => _SlidableCardsState();
}

class _SlidableCardsState extends State<SlidableCards> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  void _onScroll() {
    double cardWidth = 200 + 16; // card width + spacing
    int index = (_scrollController.offset / cardWidth).round();
    if (index != _currentIndex && index < projects.length) {
      setState(() {
        _currentIndex = index;
        selectedProject = projects[_currentIndex];
      });
      context.read<TaskCubit>().selectProject(selectedProject!);
    }
  }

  @override
  late Box<Project> projectBox; // Declare project box
  List<Project> projects = []; // List to hold loaded projects

  @override
  void initState() {
    super.initState();
    _loadProjects();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadProjects() async {
    projectBox = await Hive.openBox<Project>('projects');

    // Fetch all projects
    setState(() {
      projects = projectBox.values.toList(); // Convert HiveList to List
    });

    //  Optionally set the first project as selected (if you need it)
    if (projects.isNotEmpty) {
      selectedProject = projects.first;
     // context.read<TaskCubit>().selectProject(selectedProject!);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          SizedBox(
            height: 319.h,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return Container(
                  width: 371.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: selectedProject?.name == project.name
                          ? [
                              Color(0xFF9C2CF3), // Full opacity
                              Color(0xFF3A49F9),
                            ]
                          : [
                              Color(0xFF9C2CF3).withOpacity(0.5), // 50% opacity
                              Color(0xFF3A49F9).withOpacity(
                                  0.5), // 50% opacity // Full opacity
                            ],
                      stops: [
                        -0.1349,
                        1.0975
                      ], // This mimics the degrees in CSS
                    ),
                  ),
                  margin: EdgeInsets.only(left: 30.w),
                  padding: EdgeInsets.all(40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.panorama_photosphere,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            project.name!,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Text(
                        project.description,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      Text(DateFormat('MMMM d, y').format(project.date),

                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          _buildDashIndicator(),
        ],
      ),
    );
  }

  Widget _buildDashIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(projects.length, (index) {
        bool isActive = index == _currentIndex;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
