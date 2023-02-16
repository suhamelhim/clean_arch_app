import 'dart:async';

import 'package:mena1/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInput with BaseViewModelOutput{
  final StreamController _inputStreamController=StreamController<StateFlow>.broadcast();
  @override
  Sink get inputState=>_inputStreamController.sink;


      @override
      Stream<StateFlow> get outputState => _inputStreamController.stream.map((flowstate) => flowstate);
@override
  void dispose() {
  _inputStreamController.close();
  }
}
abstract class BaseViewModelInput{
  void start();
  void dispose();
  Sink get inputState;
}
abstract class BaseViewModelOutput{
Stream<StateFlow> get outputState;
}