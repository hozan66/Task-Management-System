abstract class CounterStates {}
//we use abstract class here to be parent and can access children classes

class CounterInitialState extends CounterStates {}

class CounterPlusState extends CounterStates {
  final int counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterStates {
  final int counter;

  CounterMinusState(this.counter);
}
