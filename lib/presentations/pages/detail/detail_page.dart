import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_active_tiket_bloc/detail_active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_all_tiket_bloc/detail_all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_historic_tiket_bloc/detail_historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_active_ticket_table.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_historic_ticket_table.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_overview_card_large.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_overview_card_small.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_ticket_gangguan_section_large.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_ticket_gangguan_section_small.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/informasi_pelanggan.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/informasi_teknisi.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class DetailPage extends StatefulWidget {
  final dynamic user;
  const DetailPage({super.key, required this.user});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    if (widget.user == null) {
      return;
    }
    if (widget.user is Teknisi) {
      context.read<DetailActiveTiketBloc>().add(
          FetchDetailActiveTiketByIdTeknisi(
              idTeknisi: widget.user.idteknisi.toString()));
      context.read<DetailHistoricTiketBloc>().add(
          FetchDetailHistoricTiketByIdTeknisi(
              idTeknisi: widget.user.idteknisi.toString()));
      context.read<DetailAllTiketBloc>().add(FetchDetailAllTiketByIdTeknisi(
          idTeknisi: widget.user.idteknisi.toString()));
    } else {
      context.read<DetailActiveTiketBloc>().add(
          FetchDetailActiveTiketByIdPelanggan(
              idPelanggan: widget.user.idpelanggan.toString()));
      context.read<DetailHistoricTiketBloc>().add(
          FetchDetailHistoricTiketByIdPelanggan(
              idPelanggan: widget.user.idpelanggan.toString()));
      context.read<DetailAllTiketBloc>().add(FetchDetailAllTiketByIdPelanggan(
          idPelanggan: widget.user.idpelanggan.toString()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      Future.microtask(() => Get.offNamed(rootRoute));
      return const Scaffold();
    }
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: light,
      ),
      body: ResponsiveWidget(
        largeScreen: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                const DetailOverviewCardLargeScreen()
              else
                const DetailOverviewCardSmallScreen(),
              //
              if (widget.user is Teknisi)
                InformasiTeknisi(teknisi: widget.user)
              else if (widget.user is Pelanggan)
                InformasiPelanggan(pelanggan: widget.user),

              if (!ResponsiveWidget.isSmallScreen(context))
                const DetailTicketGangguanSectionLarge()
              else
                const DetailTicketGangguanSectionSmall(),

              const DetailActiveTicketTable(),
              const DetailHistoricTicketTable(),
            ],
          ),
        ),
      ),
    );
  }
}
