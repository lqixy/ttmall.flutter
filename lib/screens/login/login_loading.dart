import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttmall/bloc/login/login_bloc.dart';
import 'package:ttmall/bloc/navigator/navigator_bloc.dart';
import 'package:ttmall/shared/custom_error_widget.dart';
import 'package:ttmall/shared/custom_loading_circle_widget.dart';

class LoginLoadingScreen extends StatelessWidget {
  const LoginLoadingScreen(this.mobile, this.pwd, this.code, this.tk,
      {super.key});
  final String mobile;
  final String pwd;
  final String? code;
  final int? tk;
  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(LoginLoadEvent(mobile, pwd, code, tk));
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoadedState) {
            BlocProvider.of<NavigatorBloc>(context)
                .add(NavigatorToHomeEvent(context));
            return const CustomLoadingCircleWidget();
          } else if (state is LoginErrorState) {
            return CustomErrorWidget(state.msg);
          } else {
            return const CustomLoadingCircleWidget();
          }
        },
      ),
    );
  }
}
