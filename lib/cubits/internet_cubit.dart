
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState {Initial, Gained, Loss}
class InternetCubit extends Cubit<InternetState>{
  Connectivity connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  InternetCubit() : super(InternetState.Initial){
    _streamSubscription  =   connectivity.onConnectivityChanged.listen((result) {
      if(result== ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        emit(InternetState.Gained);
      }else{
        emit(InternetState.Loss);
      }
    });
  }
  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

}