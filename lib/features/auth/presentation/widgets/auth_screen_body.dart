part of '../screens/auth/auth_screen.dart';

class AuthScreenBody extends StatelessWidget {
  final Widget content;
  final VoidCallback onTapPlayButton;
  final Widget footer;

  const AuthScreenBody({
    Key key,
    @required this.content,
    this.onTapPlayButton,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: const AssetImage('assets/images/sign_up_heading.png'),
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return content;
                  },
                ),
              ),
            ),
            if (footer != null) footer
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildPlayButton() {
    return Material(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onTapPlayButton,
        borderRadius: BorderRadius.circular(24),
        child: const Padding(
          padding: EdgeInsets.all(AppInsets.l),
          child: Icon(
            Icons.play_arrow,
            size: 32,
          ),
        ),
      ),
    );
  }
}
