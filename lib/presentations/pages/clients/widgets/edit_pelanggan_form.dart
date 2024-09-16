import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/domain/entities/phone_number.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_pelanggan_bloc/update_pelanggan_bloc.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class EditPelangganForm extends StatelessWidget {
  final Pelanggan pelanggan;
  const EditPelangganForm({super.key, required this.pelanggan});

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
                  "Edit Pelanggan",
                  style: GoogleFonts.roboto(
                      fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 48,
                ),
                BlocBuilder<UpdatePelangganBloc, UpdatePelangganState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    bool isError = state.name.displayError != null;
                    return TextFormField(
                      initialValue: pelanggan.nama,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: isError ? Colors.red : null,
                          ),
                          labelText: "Nama",
                          errorText:
                              isError ? 'Nama tidak boleh kosong!' : null,
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder()),
                      onChanged: (value) => context
                          .read<UpdatePelangganBloc>()
                          .add(OnChangedName(value: value)),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<UpdatePelangganBloc, UpdatePelangganState>(
                  buildWhen: (previous, current) =>
                      previous.alamat != current.alamat,
                  builder: (context, state) {
                    bool isError = state.alamat.displayError != null;
                    return TextFormField(
                      initialValue: pelanggan.alamat,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: isError ? Colors.red : null,
                          ),
                          labelText: "Alamat",
                          errorText:
                              isError ? 'Alamat tidak boleh kosong!' : null,
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder()),
                      onChanged: (value) {
                        context
                            .read<UpdatePelangganBloc>()
                            .add(OnChangedAlamat(value: value));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<UpdatePelangganBloc, UpdatePelangganState>(
                  buildWhen: (previous, current) =>
                      previous.noHp != current.noHp,
                  builder: (context, state) {
                    bool isError = state.noHp.displayError != null;
                    String errorMessage = '';
                    if (isError) {
                      switch (state.noHp.error) {
                        case PhoneNumberValidationError.empty:
                          errorMessage = 'Phone number cannot be empty';
                          break;
                        case PhoneNumberValidationError.notStartingWithZero:
                          errorMessage = 'Phone number must start with 0';
                          break;
                        case PhoneNumberValidationError.containsNonNumeric:
                          errorMessage =
                              'Phone number must contain only numbers';
                          break;
                        case PhoneNumberValidationError.invalidLength:
                          errorMessage =
                              'Phone number must be between 10 and 16 digits';
                          break;
                        default:
                          errorMessage = 'Invalid phone number';
                          break;
                      }
                    }
                    return TextFormField(
                      initialValue: pelanggan.nohp,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          isDense: true,
                          labelStyle: const TextStyle(fontSize: 12),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: isError ? Colors.red : null,
                          ),
                          labelText: "No HP",
                          errorText: isError ? errorMessage : null,
                          contentPadding: const EdgeInsets.all(12),
                          border: const OutlineInputBorder()),
                      onChanged: (value) {
                        context
                            .read<UpdatePelangganBloc>()
                            .add(OnChangedPhoneNumber(value: value));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<UpdatePelangganBloc, UpdatePelangganState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: state.isValid
                          ? () {
                              context
                                  .read<UpdatePelangganBloc>()
                                  .add(SubmitUpdatePelanggan());
                              context
                                  .read<UpdatePelangganBloc>()
                                  .add(ClearUpdatePelanggan());
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
