import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:goddb_task/core/di/injection_container.dart' as di;
import 'package:goddb_task/features/home/models/project.dart';
import 'package:goddb_task/features/tasks/views/pages/create_task.dart';
import 'package:goddb_task/features/home/views/pages/home_page.dart';
import 'package:goddb_task/features/tasks/views/pages/task_calender.dart';
import 'package:goddb_task/features/Auth/views/pages/signup_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/utils/configs/theme/theme_manager.dart';
import 'features/Auth/cubit/auth_cubit.dart';
import 'features/Auth/views/pages/login_page.dart';
import 'features/tasks/cubits/task_cubit.dart';
import 'features/tasks/models/task.dart';

late final taskBox;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthCubit()),
      BlocProvider(create: (_) => TaskCubit(taskBox)..loadTasks()),
    ],
    // BlocProvider(
    // create: (_) => AuthCubit(),
    child: MyApp(),
  ));
}

Future<void> init() async {

  await Firebase.initializeApp();
  
  await di.configure();
  await Hive.initFlutter();
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(TaskAdapter()); // Import from task.g.dart
  await Hive.openBox<Project>('project');
  taskBox = await Hive.openBox<Task>('tasks');

  await insertStaticProjects();
}

Future<void> insertStaticProjects() async {
  final projectBox = await Hive.openBox<Project>('projects');

  // Avoid inserting duplicates
  if (projectBox.isEmpty) {
    final project1 = Project(
      name: 'Project 1',
      description: 'Front-End Development',
      date: DateTime(2020, 10, 20),
    );

    final project2 = Project(
      name: 'Project 2',
      description: 'Back-End Development',
      date: DateTime(2020, 10, 25),
    );

    await projectBox.addAll([project1, project2]);
    print('Static projects inserted!');
  } else {
    print('Projects already exist.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(685, 1341),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            title: 'GODDB APP',
            initialRoute: '/LogIn',
            routes: {
              '/HomePage': (context) => const HomePage(),

              '/tasks': (context) => TaskCalendar(),
              '/AddTask': (context) => CreateTask(),
              '/LogIn': (context) => LoginPage(),
              '/SignUp': (context) => SignUpPage(),

              // '/profile': (context) => ProfileScreen(),
            },
            theme: AppTheme.lightTheme,
            home: const LoginPage(),
          );
        });
  }
}
