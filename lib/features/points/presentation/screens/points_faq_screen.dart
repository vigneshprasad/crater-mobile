import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/points/domain/entity/points_faq_entity.dart';
import 'package:worknetwork/features/points/domain/entity/points_rule_entity.dart';
import 'package:worknetwork/features/points/presentation/bloc/points_bloc.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class PointsFaqScreen extends StatefulWidget {
  @override
  _PointsFaqScreenState createState() => _PointsFaqScreenState();
}

class _PointsFaqScreenState extends State<PointsFaqScreen> {
  List<PointsFaq> faqs;
  List<PointsRule> rules;
  PointsBloc _bloc;

  @override
  void initState() {
    faqs = [];
    rules = [];
    _bloc = BlocProvider.of<PointsBloc>(context)
      ..add(const GetPointsFaqStarted())
      ..add(const GetPointsRulesStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointsBloc, PointsState>(
      listener: _blocListener,
      child: Scaffold(
        appBar: BaseAppBar(
          title: Text("Points Faq's"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppInsets.xl,
            vertical: AppInsets.l,
          ),
          children: [
            ..._buildFaqList(context),
            _buildPointsRules(context),
          ],
        ),
      ),
    );
  }

  void _blocListener(BuildContext context, PointsState state) {
    if (state is PointsFaqListLoaded) {
      setState(() {
        faqs = state.faqs;
      });
    } else if (state is PointsRulesListLoaded) {
      setState(() {
        rules = state.rules;
        print(rules);
      });
    }
  }

  List<Widget> _buildFaqList(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
        );
    final answerStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );
    return faqs
        .map(
          (faq) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                faq.question,
                style: headingStyle,
              ),
              const SizedBox(height: AppInsets.med),
              Text(
                faq.answer,
                style: answerStyle,
              ),
              const SizedBox(height: AppInsets.xl),
            ],
          ),
        )
        .toList();
  }

  Widget _buildPointsRules(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
        );
    final question =
        AppLocalizations.of(context).translate("rewards:wn_coins_question");
    final answer =
        AppLocalizations.of(context).translate("rewards:wn_coins_answer");
    final answerStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: headingStyle,
        ),
        const SizedBox(height: AppInsets.med),
        Text(
          answer,
          style: answerStyle,
        ),
        const SizedBox(height: AppInsets.xl),
        ...rules
            .map((rule) => _RulesRow(
                  rule: rule,
                ))
            .toList(),
        const SizedBox(height: AppInsets.xl),
      ],
    );
  }
}

class _RulesRow extends StatelessWidget {
  final PointsRule rule;

  const _RulesRow({
    Key key,
    @required this.rule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ruleStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          fontSize: 15,
          color: Colors.grey[700],
        );
    final scoreStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              rule.desc,
              style: ruleStyle,
            ),
          ),
          Text(
            '+${rule.pointsValue}',
            style: scoreStyle,
          ),
        ],
      ),
    );
  }
}
