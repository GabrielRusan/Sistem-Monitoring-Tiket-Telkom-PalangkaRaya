import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';

class LoginUsernameField extends StatelessWidget {
  const LoginUsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
              labelText: "Username",
              hintText: "admin",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          onFieldSubmitted: (value) {
            context.read<LoginBloc>().add(SignIn());
          },
          onChanged: (value) =>
              context.read<LoginBloc>().add(UsernameChanged(value: value)),
        );
      },
    );
  }
}
