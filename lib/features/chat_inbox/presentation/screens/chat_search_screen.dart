import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/components/chat_search_input/chat_search_input.dart';
import '../../../../ui/components/list_items/user_list_item/user_list_item.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/chat_user_entity.dart';
import '../bloc/chat_search/chat_search_bloc.dart';

class ChatSearchScreen extends StatefulWidget {
  @override
  _ChatSearchScreenState createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends State<ChatSearchScreen> {
  final TextEditingController _searchInputController = TextEditingController();
  String _searchString;
  ChatSearchBloc _chatSearchBloc;
  bool _showEmptyState = false;
  Timer _debounce;
  final _page = 1;

  @override
  void initState() {
    _searchString = "";
    _chatSearchBloc = KiwiContainer().resolve<ChatSearchBloc>();
    _searchInputController.addListener(_onChangeSearchString);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _chatSearchBloc.close();
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.subtitle1;
    final appBarTitle =
        AppLocalizations.of(context).translate("chat_search:title");
    return BlocProvider.value(
      value: _chatSearchBloc,
      child: BlocConsumer<ChatSearchBloc, ChatSearchState>(
        listener: (context, state) {
          if (state is ChatSearchResultsLoaded) {
            setState(() {
              _showEmptyState = true;
            });
          } else {
            setState(() {
              _showEmptyState = false;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: BaseAppBar(
              title: Text(
                appBarTitle,
                style: headerStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: Column(
              children: [
                _buildSearchInput(context),
                if (state.results.isEmpty &&
                    _searchString.isNotEmpty &&
                    _showEmptyState)
                  _buildEmptyState(context)
                else
                  _buildResultsList(context, state.results)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
      color: Colors.grey[200],
      width: width,
      height: 48,
      child: ChatSearchInput(
        controller: _searchInputController,
      ),
    );
  }

  void _onChangeSearchString() {
    _searchString = _searchInputController.text;
    if (_searchString.isNotEmpty) {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () {
        _chatSearchBloc.add(
            SendSearchUsersRequestStarted(search: _searchString, page: _page));
      });
    }
  }

  Widget _buildResultsList(BuildContext context, List<ChatUser> results) {
    return Expanded(
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return UserListItem(
            withFavorite: false,
            user: results[index],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final subTitleWidth = MediaQuery.of(context).size.width * 0.8;
    final subtitleStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(color: Colors.grey, height: 1.4);
    final headerStyle = Theme.of(context)
        .textTheme
        .subtitle2
        .copyWith(fontSize: 16, height: 2, color: Colors.grey[700]);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AppImageAssets.searchUserempty,
          ),
          SizedBox(
            width: subTitleWidth,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Sorry, no search results\n",
                    style: headerStyle,
                  ),
                  TextSpan(
                    text:
                        "Sorry we couldn't find your freind do you want to refer hime to Join WorkNetwork.",
                    style: subtitleStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
