part of '../screens/auth/auth_screen.dart';

class AuthScreenBody extends StatelessWidget {
  final Widget content;
  final VoidCallback onTapPlayButton;

  const AuthScreenBody({
    Key key,
    @required this.content,
    this.onTapPlayButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.4;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: const AssetImage('assets/images/sign_up_heading.png'),
            height: imageHeight,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: content,
          ),
        ],
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
