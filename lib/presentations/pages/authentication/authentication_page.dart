import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/user_cubit/user_cubit.dart';
import 'package:telkom_ticket_manager/presentations/pages/authentication/widgets/login_button.dart';
import 'package:telkom_ticket_manager/presentations/pages/authentication/widgets/login_password_field.dart';
import 'package:telkom_ticket_manager/presentations/pages/authentication/widgets/login_username_field.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_snackbar.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.failed) {
          errorSnackbar(context, 'Login gagal!', state.errorMessage);
        } else if (state.loginStatus == LoginStatus.success) {
          context.read<UserCubit>().getUserData();
          context.read<TeknisiBloc>().add(FetchAllTeknisi());
          Get.offNamed(rootRoute);
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        "assets/icons/logo_telkom.png",
                        height: 50,
                        width: 100,
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(children: [
                  Text(
                    "Login",
                    style: GoogleFonts.roboto(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ]),
                Row(
                  children: [
                    CustomText(
                      text: "Selamat datang di panel admin!",
                      color: lightGrey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const LoginUsernameField(),
                const SizedBox(
                  height: 15,
                ),
                const LoginPasswordField(),
                const SizedBox(
                  height: 30,
                ),
                const LoginButton(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
