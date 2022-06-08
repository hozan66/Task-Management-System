import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_app/layout/home_layout.dart';
import 'package:test_app/shared/bloc_observer.dart';

// import 'modules/counter/counter_screen.dart';
// import 'modules/login/login_screen.dart';
// import 'modules/bmi_result/bmi_result_screen.dart';
// import 'modules/bmi/bmi_screen.dart';

// import 'messenger_screen.dart';
// import 'users_screen.dart';
// import 'home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
/*
Reusable component
1. timing
2. refactor
3. quality
4. clean code
*/
