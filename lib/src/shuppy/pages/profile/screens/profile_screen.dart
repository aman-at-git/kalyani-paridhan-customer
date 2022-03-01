part of '../profile_page.dart';

class ShuppyProfileScreen extends StatelessWidget {
  const ShuppyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        context,
        enableLeading: false
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Const.margin),
        child: ListView(
          children: [
            _HeaderSection(
              fullName: userName,
              email: userEmail,
              image:
                  'https://cdn-icons-png.flaticon.com/512/164/164600.png',
            ),
            const SizedBox(height: Const.space25),
            _BodySection(),
          ],
        ),
      ),
    );
  }
}
