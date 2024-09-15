import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telkom_ticket_manager/domain/entities/admin.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_admin_bloc/update_admin_bloc.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class EditAdminForm extends StatelessWidget {
  final Admin admin;
  const EditAdminForm({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(3, 1))
              ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "X",
                        style: GoogleFonts.roboto(
                            color: lightGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Edit Admin",
                  style: GoogleFonts.roboto(
                      fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 48,
                ),
                BlocBuilder<UpdateAdminBloc, UpdateAdminState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    bool isError = state.password.displayError != null;
                    return TextFormField(
                      initialValue: admin.nama,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: isError ? Colors.red : null,
                          ),
                          labelText: "Nama",
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder()),
                      onChanged: (value) => context
                          .read<UpdateAdminBloc>()
                          .add(OnChangedName(value: value)),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<UpdateAdminBloc, UpdateAdminState>(
                  buildWhen: (previous, current) =>
                      previous.username != current.username,
                  builder: (context, state) {
                    bool isError = state.username.displayError != null;
                    return TextFormField(
                      initialValue: admin.username,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: isError ? Colors.red : null,
                          ),
                          labelText: "Username",
                          errorText:
                              isError ? 'Username tidak boleh kosong!' : null,
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder()),
                      onChanged: (value) {
                        context
                            .read<UpdateAdminBloc>()
                            .add(OnChangedUsername(value: value));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<UpdateAdminBloc, UpdateAdminState>(
                  buildWhen: (previous, current) =>
                      previous.password != current.password,
                  builder: (context, state) {
                    bool isError = state.password.displayError != null;
                    return TextFormField(
                      initialValue: admin.pass,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: isError ? Colors.red : null,
                          ),
                          labelText: "Password",
                          errorText:
                              isError ? 'Password tidak boleh kosong!' : null,
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder()),
                      onChanged: (value) {
                        context
                            .read<UpdateAdminBloc>()
                            .add(OnChangedPassword(value: value));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<UpdateAdminBloc, UpdateAdminState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: state.isValid
                          ? () {
                              context
                                  .read<UpdateAdminBloc>()
                                  .add(SubmitUpdateAdmin());
                              context
                                  .read<UpdateAdminBloc>()
                                  .add(ClearUpdateAdmin());
                            }
                          : null,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: state.isValid ? active : Colors.grey,
                          ),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: const CustomText(
                            text: 'Update',
                            color: Colors.white,
                          )),
                    );
                  },
                ),
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
