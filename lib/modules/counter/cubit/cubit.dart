import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/modules/counter/cubit/states.dart';

//all logic and operations inside cubit or bloc

class CounterCubit extends Cubit<CounterStates> {
  //Cubit needs the states that I have but cubit can has one state
  CounterCubit()
      : super(CounterInitialState()); //CounterCubit needs father constructor

  //to be more easier when use this cubit in many places
  static CounterCubit get(context) => BlocProvider.of(context);
  //of will return T
  //T can be any type of the bloc

  int counter = 1;

  void minus() {
    counter--;
    emit(CounterMinusState(
        counter)); //emit means send, it will change that (parameter state) state
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
