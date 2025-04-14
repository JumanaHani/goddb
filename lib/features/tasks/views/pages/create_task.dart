import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goddb_task/features/home/views/widgets/filters_card.dart';
import 'package:goddb_task/features/tasks/models/task.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/configs/theme/app_colors.dart';
import '../../cubits/task_cubit.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  List<String> categories = [
    'Design',
    'Meeting',
    'Coding',
    'BDE',
    'Testing',
    'Quick call'
  ];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endtTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String selectedCategory = 'Design'; // Default selecte
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('MMM dd, yyyy').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final formattedTime = picked.format(context);
      _startTimeController.text = formattedTime;
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );


    if (picked != null) {
      final formattedTime = picked.format(context);
      _endtTimeController.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF9C2CF3),
                        Color(0xFF3A49F9),
                      ],
                      stops: [
                        -0.1349,
                        1.0975
                      ], // This mimics the degrees in CSS
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back,
                                        color: Colors.white)),
                                Text(
                                  'Create a Task',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 52.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(color: Colors.white),
                                  cursorColor: Colors.white,
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter a task name',
                                    filled: false,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Text('Date',
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(color: Colors.white),
                                  controller: _dateController,
                                  readOnly: true,
                                  onTap: () => _pickDate(context),
                                  decoration: InputDecoration(
                                    hintText: 'Enter a start date',
                                    filled: false,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 52.w),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '  Start Time',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  color: Color(0xffBFC8E8)),
                                        ),
                                        Container(
                                            width: 150,
                                            child: TextFormField(
                                              controller: _startTimeController,
                                              readOnly: true,
                                              onTap: () =>
                                                  _selectStartTime(context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                              decoration: InputDecoration(
                                                  hintText: '01:12 PM',
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none),
                                            )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('  End Time',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                    color: Color(0xffBFC8E8))),
                                        Container(
                                            width: 150,
                                            child: TextFormField(
                                              controller: _endtTimeController,
                                              readOnly: true,
                                              onTap: () =>
                                                  _selectEndTime(context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                              decoration: InputDecoration(
                                                hintText: '02:12 PM',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                //For start and end time
                                Divider(
                                  color: Color(0xffBFC8E8),
                                  height: 1,
                                  indent: 5,
                                  endIndent: 20,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  "Description",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Color(0xffBFC8E8)),
                                ),
                                TextFormField(
                                    controller: _descriptionController,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: 'Enter description...',
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w500),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                    ),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500)),
                                Divider(
                                  color: Color(0xffBFC8E8),
                                  height: 1,
                                  indent: 5,
                                  endIndent: 20,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),

                                Text(
                                  "Category",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Color(0xffBFC8E8)),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GridView.count(
                                  crossAxisCount: 3,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio:
                                      2.2, // width / height ratio, tweak this value
                                  children: categories.map((category) {
                                    final isSelected =
                                        category == selectedCategory;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategory = category;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          gradient: isSelected
                                              ? LinearGradient(
                                                  colors: [
                                                    Color(0xFF9C2CF3),
                                                    Color(0xFF3A49F9)
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : null,
                                          color: isSelected
                                              ? null
                                              : Color(0xffE5EAFC),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.transparent
                                                : Colors.white24,
                                          ),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: Color(0x66E2E2E2),
                                                    offset: Offset(4, 6),
                                                    blurRadius: 12,
                                                  )
                                                ]
                                              : [],
                                        ),
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Color(0xff2E3A59),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: 80.h,
                                ),
                                Center(
                                  child: Container(
                                    width: 600.w,
                                    height: 92.h,
                                    child: InkWell(
                                      onTap: () {
                                        final name =
                                            _nameController.text.trim();
                                        final dateText =
                                            _dateController.text.trim();
                                        final startTimeText =
                                            _startTimeController.text.trim();
                                        final endTimeText =
                                            _endtTimeController.text.trim();
                                        final description =
                                            _descriptionController.text.trim();

                                        if (name.isEmpty ||
                                            dateText.isEmpty ||
                                            startTimeText.isEmpty ||
                                            endTimeText.isEmpty ||
                                            description.isEmpty ||
                                            selectedCategory == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Please fill all fields")),
                                          );
                                          return;
                                        }
                                        final date = DateFormat("MMM dd, yyyy")
                                            .parse(_dateController.text);
                                        final startTimeOfDay =
                                            DateFormat("hh:mm a").parse(
                                                _startTimeController.text);
                                        final endTimeOfDay =
                                            DateFormat("hh:mm a").parse(
                                                _endtTimeController.text);
                                        final startTime = DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          startTimeOfDay.hour,
                                          startTimeOfDay.minute,
                                        );

                                        final endTime = DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          endTimeOfDay.hour,
                                          endTimeOfDay.minute,
                                        );
                                        final task = Task(
                                          name: _nameController.text,
                                          date: date,
                                          startTime: startTime,
                                          endTime: endTime,
                                          description:
                                              _descriptionController.text,
                                          category: selectedCategory,
                                        );

                                        // Access cubit and save
                                        context
                                            .read<TaskCubit>()
                                            .saveTask(task);

                                        // Optional: Clear fields or navigate back
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF9C2CF3),
                                              Color(0xFF3A49F9),
                                            ],
                                            stops: [
                                              -0.1349,
                                              1.0975
                                            ], // Simulates the angles and stops
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(
                                                  0x66E2E2E2), // 0x66 = 40% opacity
                                              offset: Offset(17, 26),
                                              blurRadius: 25,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              75), // Optional
                                        ),
                                        child: Center(
                                            child: Text(
                                          'Create Task',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        )),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
