import 'package:bloc/bloc.dart';

//MyBlocObserver helps in (We will keep track where are we)
class MyBlocObserver extends BlocObserver {
  //bloc: ^7.0.0
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(
        'onCreate -- ${bloc.runtimeType}'); //runtimeType determines which type of object bloc is
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
