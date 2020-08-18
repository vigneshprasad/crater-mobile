part of 'auth_screen.dart';

class SignupBodyTemplate extends StatelessWidget {
  final Widget content;
  final VoidCallback onTapPlayButton;

  const SignupBodyTemplate({
    Key key,
    this.content,
    this.onTapPlayButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image(
                      image:
                          const AssetImage('assets/images/sign_up_heading.png'),
                      height: imageHeight,
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.45,
                      top: MediaQuery.of(context).size.height * 0.2,
                      child: _buildPlayButton(),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: content,
                )
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey[200],
          height: 48,
          child: Center(
            child: Text("Singup for app"),
          ),
        )
      ],
    );
  }

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
