import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';

class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({super.key});

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          obscureText: !isVisible,
          decoration: InputDecoration(
              labelText: "Password",
              hintText: "123",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: isVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          onChanged: (value) =>
              context.read<LoginBloc>().add(PasswordChanged(value: value)),
        );
      },
    );
  }
}
