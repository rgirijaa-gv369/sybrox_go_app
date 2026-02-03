import 'package:flutter_test/flutter_test.dart';
import 'package:sybrox_go_app/features/home/presentation/bloc/home_bloc.dart';

void main() {
  test('RideBloc should be instantiated without error', () {
    try {
      final bloc = RideBloc();
      print('RideBloc created successfully: ${bloc.state}');
    } catch (e, stack) {
      print('RideBloc failure: $e');
      print(stack);
      rethrow;
    }
  });
}
