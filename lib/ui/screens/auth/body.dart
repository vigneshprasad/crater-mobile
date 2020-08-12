part of 'auth_screen.dart';

class SignupBodyTemplate extends StatelessWidget {
  final Widget content;

  const SignupBodyTemplate({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = <Widget>[
      const Image(
        image: AssetImage('assets/images/sign_up_heading.png'),
      ),
      const SizedBox(
        height: 16,
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: content,
      )
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: layout,
      ),
    );
  }
}
