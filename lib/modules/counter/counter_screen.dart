import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/modules/counter/cubit/cubit.dart';
import 'package:test_app/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var s =BlocProvider.of(context); //in this way I can create an object from CounterCubit class

    return BlocProvider(
      //flutter_bloc: ^7.0.0
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        //BlocConsumer needs two generic type
        //it allows to listen to the state changes
        listener: (BuildContext context, CounterStates state) {
          //state here is an object of CounterStates
          if (state is CounterMinusState) {
            // print('Minus State ${state.counter}');
          }
          if (state is CounterPlusState) {
            // print('Plus State ${state.counter}');
          }
        },
        //listener and builder property work together
        builder: (BuildContext context, CounterStates state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      //CounterCubit.get(context) this is an object from CounterCubit class
                      CounterCubit.get(context).minus();
                    },
                    child: Text('MINUS'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      '${CounterCubit.get(context).counter}', //just this part will rebuild when the state is changing
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.w900),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: Text('PLUS'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
