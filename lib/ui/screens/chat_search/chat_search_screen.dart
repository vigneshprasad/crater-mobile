import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/chat_search/bloc/chat_search_bloc.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/components/chat_search_input/chat_search_input.dart';
import 'package:worknetwork/ui/components/list_items/user_list_item/user_list_item.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class ChatSearchScreen extends StatefulWidget {
  @override
  _ChatSearchScreenState createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends State<ChatSearchScreen> {
  final TextEditingController _searchInputController = TextEditingController();
  String _searchString;
  ChatSearchBloc _chatSearchBloc;
  WebSocketRepository _socketRepository;
  List<ChatUser> _results = [];
  bool showEmptyState = false;
  Timer _debounce;

  @override
  void initState() {
    showEmptyState = false;
    _searchString = "";
    _socketRepository = RepositoryProvider.of<WebSocketRepository>(context);
    _chatSearchBloc = ChatSearchBloc(webSocketRepository: _socketRepository);
    _searchInputController.addListener(_onChangeSearchString);
    super.initState();
  }

  @override
  void dispose() {
    _chatSearchBloc.add(
        const ChatSearchUsersStarted(options: AllUserRequestOptions.initial()));
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
      child: BlocListener<ChatSearchBloc, ChatSearchState>(
        listener: (context, state) {
          if (state is ChatSearchResultsLoaded) {
            setState(() {
              _results = [...state.users];
              showEmptyState = true;
            });
          }
        },
        child: Scaffold(
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
              if (_results.isNotEmpty && _searchString.isNotEmpty)
                _buildResultsList(context)
              else if (_results.isEmpty &&
                  _searchString.isNotEmpty &&
                  showEmptyState)
                _buildEmptyState(context)
            ],
          ),
        ),
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
    if (_searchInputController.text.isEmpty) {
      showEmptyState = false;
    }
    if (_searchString.isNotEmpty) {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 200), () {
        final searchOptions = const AllUserRequestOptions.initial().copyWith(
          search: _searchString,
        );
        _chatSearchBloc.add(ChatSearchUsersStarted(options: searchOptions));
      });
    }
  }

  Widget _buildResultsList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _results.length,
        itemBuilder: (context, index) {
          return UserListItem(
            withFavorite: false,
            user: _results[index],
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
