part of '../profile_page.dart';

class ShuppyEditProfileScreen extends StatefulWidget {
  const ShuppyEditProfileScreen({Key? key}) : super(key: key);

  @override
  _ShuppyEditProfileScreenState createState() => _ShuppyEditProfileScreenState();
}

class _ShuppyEditProfileScreenState extends State<ShuppyEditProfileScreen> {
  TextEditingController? _fullNameController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _addressController;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as UserModel;
    _fullNameController = TextEditingController(text: args.fullName);
    _phoneNumberController = TextEditingController(text: args.phoneNumber);
    _addressController = TextEditingController(text: args.address);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: AppLocalizations.of(context)!.edit_profile,
        actions: [
          CustomTextButton(
            label: AppLocalizations.of(context)!.save,
            textColor: theme.primaryColor,
            onTap: () {
              FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(<String, dynamic>{
                'name':_fullNameController!.text,
              });
              FirebaseFirestore.instance
                  .collection('allUsers')
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  if(doc['uid'].toString() == FirebaseAuth.instance.currentUser!.uid){
                    FirebaseFirestore.instance.collection('allUsers').doc(doc.id).update(<String, dynamic>{
                      'name':_fullNameController!.text,
                    });
                  }
                });
              });
              setState(() {
                userName = _fullNameController!.text;
              });
              FocusScope.of(context).requestFocus(FocusNode());
              Get.back<dynamic>();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Const.margin),
        children: [
          _BuildChangePhotoProfile(
            onChangeImageTap: () async {
              await showToast(msg: 'Change profile photo tapped');
            },
          ),
          const SizedBox(height: Const.space25),
          _BuildFormEditProfile(
            fullNameController: _fullNameController,
            phoneNumberController: _phoneNumberController,
            addressController: _addressController,
          ),
        ],
      ),
    );
  }
}
