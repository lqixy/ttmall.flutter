import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ttmall/models/login/api/request/api_login_request.dart';
import 'package:ttmall/repositories/login/login_repository.dart';
import 'package:ttmall/services/jsp_util.dart';
import 'package:ttmall/utils/app_extensions.dart';
import 'package:ttmall/utils/uidata.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository repository = GetIt.instance.get<LoginRepository>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginLoadEvent>(
      (event, emit) async {
        emit(LoginLoadingState());
        try {
          var response = await repository.login(ApiLoginRequest(
              loginname: event.mobile,
              pwd: event.pwd,
              vercode: event.code,
              tk: event.tk));
          JSpUtil.instance.setString(UIData.authToken, response.key!);
          emit(LoginLoadedState(response.key!, response.expires));
        } catch (e) {
          emit(LoginErrorState(e.toString()));
        }
      },
    );
  }
}
