import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:test_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:test_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:test_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  //we write this statement of parent constructor in order to start with this state

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
    //when I change the state here then it will listen and change(rebuild the changes only)
  }

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db', //name of the database
      /*
      if name of database exist it will execute onOpen property directly
      if name of database doesn't exist it will execute onCreate then onOpen property
      */
      version:
          1, // I will update the version when I change the database structure
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('Database Created');
        database
            .execute(//execute returns Future<void>
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Table Created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database Opened');
      },
    ).then((value) {
      //then method that guarantees me that the future operation is finished
      // and after that then method it will be execute
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    //return dynamic
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When New Record ${error.toString()}');
      });

      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({@required String status, @required int id}) async {
    database.rawUpdate(
        'UPDATE tasks SET status=? WHERE id=?', ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({@required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id=?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
