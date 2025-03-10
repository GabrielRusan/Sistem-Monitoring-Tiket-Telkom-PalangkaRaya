import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/add_teknisi_bloc/add_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/admin_bloc/admin_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/all_tiket_bloc/all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/delete_teknisi_bloc/delete_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/historic_tiket_bloc/historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/login_bloc/login_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/odp_bloc/odp_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/pelanggan_bloc/pelanggan_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/rekap_absen_bloc/rekap_absen_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_admin_bloc/update_admin_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_pelanggan_bloc/update_pelanggan_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_teknisi_bloc/update_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/user_cubit/user_cubit.dart';
import 'package:telkom_ticket_manager/utils/controllers.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/presentations/widgets/large_screen.dart';
import 'package:telkom_ticket_manager/presentations/widgets/side_menu.dart';
import 'package:telkom_ticket_manager/presentations/widgets/small_screen.dart';
import 'package:telkom_ticket_manager/presentations/widgets/top_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({super.key});

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    context.read<UserCubit>().getUserData();
    context.read<TeknisiBloc>().add(FetchAllTeknisi());
    context.read<TeknisiBloc>().add(FetchAllTeknisi());
    context.read<ActiveTiketBloc>().add(FetchActiveTiket());
    context.read<AllTiketBloc>().add(FetchAllTiket());
    context.read<HistoricTiketBloc>().add(FetchHistoricTiket());
    context.read<AdminBloc>().add(FetchAllAdmin());
    context.read<PelangganBloc>().add(FetchAllPelanggan());
    context.read<OdpBloc>().add(FetchOdp());
    context.read<RekapAbsenBloc>().add(const FetchRekapAbsen(
          filter: 'today',
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state.status == AdminStatus.tokenInvalid) {
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dismissOnTouchOutside: false,
                dialogType: DialogType.warning,
                animType: AnimType.scale,
                title: 'Warning!',
                desc: 'Sesi anda telah berakhir!',
                onDismissCallback: (type) {
                  context.read<UserCubit>().signOut();
                  context.read<LoginBloc>().add(ClearLoginField());
                  Get.offAllNamed(authenticationPageRoute);
                  menuController.changeActiveItemTo(overviewPageDisplayName);
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            }
          },
        ),
        BlocListener<DeleteTeknisiBloc, DeleteTeknisiState>(
            listenWhen: (previous, current) {
          return previous == current || previous != current;
        }, listener: (context, state) {
          if (state is LoadingDeleteTeknisi) {
            AwesomeDialog(
                context: context,
                width: 400,
                dialogType: DialogType.noHeader,
                dismissOnTouchOutside: false,
                animType: AnimType.scale,
                body: const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )).show();
          } else if (state is SuccessDeleteTeknisi) {
            Navigator.pop(context);
            AwesomeDialog(
              context: context,
              width: 400,
              headerAnimationLoop: false,
              dialogType: DialogType.success,
              animType: AnimType.scale,
              title: 'Success!',
              desc: state.message,
              onDismissCallback: (type) {
                context.read<TeknisiBloc>().add(FetchAllTeknisi());
              },
              btnOkOnPress: () {},
              btnCancelOnPress: () {},
            ).show();
          } else if (state is FailedDeleteTeknisi) {
            Navigator.pop(context);
            AwesomeDialog(
              context: context,
              width: 400,
              headerAnimationLoop: false,
              dialogType: DialogType.error,
              animType: AnimType.scale,
              title: 'Failed!',
              desc: state.message,
              onDismissCallback: (type) {
                context.read<TeknisiBloc>().add(FetchAllTeknisi());
              },
              btnOkOnPress: () {},
              btnCancelOnPress: () {},
            ).show();
          } else if (state is WarningDeleteTeknisi) {
            AwesomeDialog(
              context: context,
              width: 400,
              headerAnimationLoop: false,
              dialogType: DialogType.warning,
              animType: AnimType.scale,
              title: 'Warning!',
              desc:
                  'Apakah anda yakin ingin menghapus ${state.namaTeknisi}?\nSemua data yang berhubungan akan ikut terhapus!',
              btnOkOnPress: () {
                context
                    .read<DeleteTeknisiBloc>()
                    .add(DeleteTeknisi(idTeknisi: state.idTeknisi));
              },
              btnCancelOnPress: () {},
            ).show();
          }
        }),
        BlocListener<AddTeknisiBloc, AddTeknisiState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.inProgress) {
              AwesomeDialog(
                  context: context,
                  width: 400,
                  dialogType: DialogType.noHeader,
                  dismissOnTouchOutside: false,
                  animType: AnimType.scale,
                  body: const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )).show();
            } else if (state.status == FormzSubmissionStatus.failure) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Failed!',
                desc: state.errorMessage,
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<TeknisiBloc>().add(FetchAllTeknisi());
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            } else if (state.status == FormzSubmissionStatus.success) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'Success!',
                desc: 'Berhasil menambah teknisi!',
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<TeknisiBloc>().add(FetchAllTeknisi());
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            }
          },
        ),
        BlocListener<UpdateTeknisiBloc, UpdateTeknisiState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.inProgress) {
              AwesomeDialog(
                  context: context,
                  width: 400,
                  dialogType: DialogType.noHeader,
                  dismissOnTouchOutside: false,
                  animType: AnimType.scale,
                  body: const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )).show();
            } else if (state.status == FormzSubmissionStatus.failure) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Failed!',
                desc: state.errorMessage,
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<TeknisiBloc>().add(FetchAllTeknisi());
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            } else if (state.status == FormzSubmissionStatus.success) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'Success!',
                desc: 'Berhasil update teknisi!',
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<TeknisiBloc>().add(FetchAllTeknisi());
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            }
          },
        ),
        BlocListener<UpdateAdminBloc, UpdateAdminState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.inProgress) {
              AwesomeDialog(
                  context: context,
                  width: 400,
                  dialogType: DialogType.noHeader,
                  dismissOnTouchOutside: false,
                  animType: AnimType.scale,
                  body: const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )).show();
            } else if (state.status == FormzSubmissionStatus.failure) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Failed!',
                desc: state.errorMessage,
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<AdminBloc>().add(FetchAllAdmin());
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            } else if (state.status == FormzSubmissionStatus.success) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'Success!',
                desc: 'Berhasil update data diri!',
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<AdminBloc>().add(FetchAllAdmin());
                  context.read<UserCubit>().getUserData();
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            }
          },
        ),
        BlocListener<UpdatePelangganBloc, UpdatePelangganState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.inProgress) {
              AwesomeDialog(
                  context: context,
                  width: 400,
                  dialogType: DialogType.noHeader,
                  dismissOnTouchOutside: false,
                  animType: AnimType.scale,
                  body: const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )).show();
            } else if (state.status == FormzSubmissionStatus.failure) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Failed!',
                desc: state.errorMessage,
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<PelangganBloc>().add(FetchAllPelanggan());
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            } else if (state.status == FormzSubmissionStatus.success) {
              Navigator.pop(context);
              AwesomeDialog(
                context: context,
                width: 400,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'Success!',
                desc: 'Berhasil update data pelanggan!',
                onDismissCallback: (type) {
                  Navigator.pop(context);
                  context.read<PelangganBloc>().add(FetchAllPelanggan());
                  context.read<UserCubit>().getUserData();
                },
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
              ).show();
            }
          },
        ),
      ],
      child: Scaffold(
        key: scaffoldKey, // biar tau drawer scaffold mana yang dibuka
        extendBodyBehindAppBar: true,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: const Drawer(
          child: SideMenu(),
        ),
        body: const ResponsiveWidget(
          largeScreen: LargeScreen(),
          smallScreen: SmallScreen(),
        ),
      ),
    );
  }
}
