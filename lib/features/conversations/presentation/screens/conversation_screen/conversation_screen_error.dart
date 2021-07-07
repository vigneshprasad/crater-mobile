part of 'conversation_screen.dart';

class _ConversationError extends StatelessWidget {
  final Failure failure;

  const _ConversationError({
    Key key,
    @required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (failure is ConversationFailure) {
      final _failure = failure as ConversationFailure;
      if (_failure.errorCode == ConversationFailuresType.groupNotFound) {
        final labelStyle = Theme.of(context).textTheme.bodyText1;
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AppImageAssets.groupNotFound,
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                Text(
                  _failure.message,
                  style: labelStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppInsets.xl),
                RaisedButton(
                  onPressed: () {
                    ExtendedNavigator.of(context).maybePop();
                  },
                  child: const Text("Return Home"),
                )
              ],
            ),
          ),
        );
      }
    }

    return Container();
  }
}
