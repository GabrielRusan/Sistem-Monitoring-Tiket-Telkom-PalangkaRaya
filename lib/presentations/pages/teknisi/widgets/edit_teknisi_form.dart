import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_teknisi_bloc/update_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class EditTeknisiForm extends StatelessWidget {
  final Teknisi teknisi;
  const EditTeknisiForm({super.key, required this.teknisi});

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
                  "Edit Teknisi",
                  style: GoogleFonts.roboto(
                      fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 48,
                ),
                BlocBuilder<UpdateTeknisiBloc, UpdateTeknisiState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    bool isError = state.name.displayError != null;
                    return TextFormField(
                      initialValue: teknisi.nama,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: isError ? Colors.red : null,
                          ),
                          errorText:
                              isError ? 'Nama tidak boleh kosong!' : null,
                          labelText: "Nama",
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder()),
                      onChanged: (value) => context
                          .read<UpdateTeknisiBloc>()
                          .add(OnChangedName(value: value)),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<UpdateTeknisiBloc, UpdateTeknisiState>(
                  buildWhen: (previous, current) =>
                      previous.username != current.username,
                  builder: (context, state) {
                    bool isError = state.username.displayError != null;
                    return TextFormField(
                      initialValue: teknisi.username,
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
                            .read<UpdateTeknisiBloc>()
                            .add(OnChangedUsername(value: value));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<UpdateTeknisiBloc, UpdateTeknisiState>(
                  buildWhen: (previous, current) =>
                      previous.password != current.password,
                  builder: (context, state) {
                    bool isError = state.password.displayError != null;
                    return TextFormField(
                      initialValue: teknisi.pass,
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
                            .read<UpdateTeknisiBloc>()
                            .add(OnChangedPassword(value: value));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<UpdateTeknisiBloc, UpdateTeknisiState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: state.isValid
                          ? () {
                              context
                                  .read<UpdateTeknisiBloc>()
                                  .add(SubmitUpdateTeknisi());
                              context
                                  .read<UpdateTeknisiBloc>()
                                  .add(ClearUpdateTeknisi());
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
