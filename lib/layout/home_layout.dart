import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; //for date
// import 'package:sqflite/sqflite.dart';
// import 'package:test_app/modules/archived_tasks/archived_tasks_screen.dart';
// import 'package:test_app/modules/done_tasks/done_tasks_screen.dart';
// import 'package:test_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:test_app/shared/components/components.dart';
// import 'package:test_app/shared/components/constants.dart';
import 'package:test_app/shared/cubit/cubit.dart';
import 'package:test_app/shared/cubit/states.dart';

// 1. create database
// 2. create tables
// 3. open database
// 4. insert to database
// 5. get from database
// 6. update in database
// 7. delete from database

class HomeLayout extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      //First dot consider the object saved in the variable(object) and Second dot to access
      child: BlocConsumer<AppCubit, AppStates>(
        //AppCubit work on it
        //AppStates listen to it
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          //putting the object in the variable because I will using it in many places in this screen

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit
                  .screens[cubit.currentIndex], //execute when condition is true
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ), //execute when condition is false
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // insertToDatabase();
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultFormField(
                                          controller: titleController,
                                          type: TextInputType.text,
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'Title Must Not Be Empty';
                                            }

                                            return null;
                                          },
                                          label: 'Task Title',
                                          prefix: Icons.title),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      defaultFormField(
                                          controller: timeController,
                                          type: TextInputType.datetime,
                                          onTap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              timeController.text = value
                                                  .format(context)
                                                  .toString();
                                              print(value.format(context));
                                              //format(context) convert object into normal time 1:14 AM
                                            });
                                          },
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'Time Must Not Be Empty';
                                            }

                                            return null;
                                          },
                                          label: 'Task Time',
                                          prefix: Icons.watch_later_outlined),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      defaultFormField(
                                          controller: dateController,
                                          type: TextInputType.datetime,
                                          onTap: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.parse(
                                                        '2022-09-03'))
                                                .then((value) {
                                              // print(value.toString()); //2021-08-04 00:00:00.000
                                              // print(DateFormat.yMMMd().format(value)); //Aug 4, 2021

                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value);
                                            });
                                          },
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'Date Must Not Be Empty';
                                            }

                                            return null;
                                          },
                                          label: 'Task Date',
                                          prefix: Icons.calendar_today),
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 20.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                    // Navigator.pop(context); //I don't need here because I close showBottomSheet with my own hand
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex:
                  cubit.currentIndex, // 0 by default it shows the selected item
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outlined),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   return 'Hozan Ageed Farho';
  // }
}
