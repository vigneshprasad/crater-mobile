import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:worknetwork/core/widgets/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/roundtable/presentation/widgets/editable_text_field/editable_text_field.dart';

import '../../../../../constants/theme.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import 'roundtable_screen_state.dart';

class RoundTableScreen extends HookWidget {
  final int id;

  const RoundTableScreen({
    @PathParam("id") this.id,
  });

  @override
  Widget build(BuildContext context) {
    final roundTableState =
        useProvider(roundTableStateNotifierProvier(id).state);
    return Scaffold(
      appBar: BaseAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _onShare,
          ),
        ],
      ),
      body: roundTableState.when(
        loading: () => _Loader(),
        data: (table) => _RoundTableLoaded(table: table),
        error: (error, st) => Container(),
      ),
    );
  }

  void _onShare() {
    Share.share("Share WorkNetwork");
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _RoundTableLoaded extends StatelessWidget {
  final RoundTable table;

  const _RoundTableLoaded({
    Key key,
    this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final categoryStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16,
          color: primaryColor,
        );
    final agendaStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 22,
        );
    final startDateFormat = DateFormat("dd MMM, hh:mm a");
    final dateStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.grey,
        );
    final descriptionStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );
    final pageLabelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          color: primaryColor,
          fontWeight: FontWeight.w700,
        );
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.xl, vertical: AppInsets.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(table.agenda.category.name, style: categoryStyle),
                const SizedBox(height: AppInsets.sm),
                Text(table.agenda.name, style: agendaStyle),
                const SizedBox(height: AppInsets.sm),
                Text(startDateFormat.format(table.start), style: dateStyle),
                const SizedBox(height: AppInsets.l),
                EditableTextField(text: table.description, editable: true),
                const SizedBox(height: AppInsets.xl),
                Text("Speakers(${table.speakers.length})",
                    style: pageLabelStyle),
                const SizedBox(height: AppInsets.l),
                Wrap(
                  spacing: AppInsets.xl,
                  children: table.speakers
                      .map((speaker) => _SpeakerAvatar(speaker: speaker))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        ..._buildActionButton(context),
      ],
    );
  }

  List<Widget> _buildActionButton(BuildContext context) {
    final List<Widget> items = [];
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    final isSpeaker =
        table.speakers.where((speaker) => speaker.pk == user.pk).isNotEmpty;

    final overlay = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 112,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.0),
            ],
          ),
        ),
      ),
    );

    if (user.pk == table.host.pk) {
      items.add(overlay);

      items.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppInsets.xxl),
            child: BaseLargeButton(
              width: MediaQuery.of(context).size.width * 0.6,
              onPressed: () {},
              child: Text("Go Live"),
            ),
          ),
        ),
      );
    } else if (!isSpeaker) {
      items.add(overlay);

      items.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppInsets.xxl),
            child: BaseLargeButton(
              width: MediaQuery.of(context).size.width * 0.6,
              onPressed: () {},
              child: Text("Join Meeting"),
            ),
          ),
        ),
      );
    }

    return items;
  }
}

class _SpeakerAvatar extends StatelessWidget {
  final Speaker speaker;

  const _SpeakerAvatar({
    Key key,
    this.speaker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(speaker.photo),
        ),
        const SizedBox(height: AppInsets.med),
        SizedBox(
          width: 72,
          child: Text(
            speaker.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
