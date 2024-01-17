import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
import '../widgets/user_profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  ///======================================== All Variables ================================================================================///
  /// Form Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Image Picker variables and Instance
  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  ///*** Add all controllers
  UserData userData = AuthUtility.userInfo.data!;                                   /// *** taking for Previous Data from saved data

  //final TextEditingController _emailTEController = TextEditingController(text: AuthUtility.userInfo.data?.email ?? '');

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _productTotalPriceTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  
  bool _profileUpdateInProgress = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEController.text = userData?.email ?? '';                            /// *** taking for Previous Data from saved data
    _firstNameTEController.text = userData?.firstName ?? '';                    /// *** taking for Previous Data from saved data
    _lastNameTEController.text = userData?.lastName ?? '';                      /// *** taking for Previous Data from saved data
    _mobileTEController.text = userData?.mobile ?? '';                          /// *** taking for Previous Data from saved data
  }

  ///---------------------------------------- profileUpdate() Update Profile API Call ------------------------------------------------------///
  Future<void> profileUpdate() async {
    _profileUpdateInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestBody = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "photo": ""
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    _profileUpdateInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      userData.firstName = _firstNameTEController.text.trim();
      userData.lastName = _lastNameTEController.text.trim();
      userData.mobile = _mobileTEController.text.trim();
      AuthUtility.updateUserInfo(userData);
      _passwordTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Updated'),),);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Updated failes! Try again'),),);
      }
    }
    
  }


  ///======================================== Scaffold Part ================================================================================///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///---------------------------------------- User Profile AppBar --------------------------------------------------------------///
              const UserProfileAppBar(
                isUpdateScreen: true,
              ),
              const SizedBox(height: 24,),
              ///-------------------------------------- Form Part --------------------------------------------------------------------------///
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///-------------------------------------- UpDate Profile Text ----------------------------------------------------------///
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Update Profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 16,),
                      ///-------------------------------------- Photo Upload Field -----------------------------------------------------------///
                      InkWell(
                        onTap: (){
                          selectImage();                                          /// new for Upload image
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                color: Colors.grey,
                                child: const Text('Photos', style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                              const SizedBox(width: 16,),
                              Visibility(
                                visible: imageFile != null,                       /// new add for upLoad Image
                                child: Text(imageFile?.name ?? ''),               /// new add for upLoad Image
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      ///-------------------------------------- Email TextFormField ----------------------------------------------------------///
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,                                           ///*** Read Only ( We can not be change )
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: ( String? value){
                          if (value?.trim().isEmpty ?? true){
                            return 'Enter Your Email Address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12,),
                      ///-------------------------------------- First Name TextFormField -----------------------------------------------------///
                      TextFormField(
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                        validator: ( String? value){
                          if (value?.trim().isEmpty ?? true){
                            return 'Enter Your First Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      ///-------------------------------------- Last Name TextFormField ------------------------------------------------------///
                      TextFormField(
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        validator: ( String? value){
                          if (value?.trim().isEmpty ?? true){
                            return 'Enter Your Last Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12,),
                      ///-------------------------------------- Mobile TextFormField ---------------------------------------------------------///
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                        validator: ( String? value){
                          if ((value?.trim().isEmpty ?? true) || value!.length  < 11){
                            return 'Enter Your valid Mobile Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12,),
                      ///-------------------------------------- Password TextFormField -------------------------------------------------------///
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 30,),
                      ///-------------------------------------- Update Elevated Button -------------------------------------------------------///
                      SizedBox(
                        width: double.infinity,
                          child: _profileUpdateInProgress ? const Center(child: CircularProgressIndicator(),) : ElevatedButton(
                        onPressed: () {
                          if ( _formKey.currentState!.validate()){
                            profileUpdate();
                          }
                        },
                        child: Text('Update'),
                      ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///======================================== Image Picker Plugin Use Function ================================================================///
  void selectImage() {
    //ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null){
        imageFile = xFile;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }


}
