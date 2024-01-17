import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/auth_utility.dart';
import '../screens/auth/login_screen.dart';
import '../screens/update_profile_screen.dart';

class UserProfileAppBar extends StatefulWidget {
  final bool? isUpdateScreen;
  const UserProfileAppBar({
    super.key, this.isUpdateScreen,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // onTap: () {
      //   if ((widget.isUpdateScreen ?? false) == false){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(),),);
      //   }
      // },
      backgroundColor: Colors.green,
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
      //   radius: 15,
      // ),
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(),),);
          }
        },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    child: CachedNetworkImage(
                      placeholder: (_, __) => Image.asset('assets/images/user_image.jpg'),
                      imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                      errorWidget: (_, __, ___) => Icon(Icons.account_circle_outlined),

                    //backgroundImage: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),

                    // backgroundImage: NetworkImage(
                    //   AuthUtility.userInfo.data?.photo ?? '',
                    // ),

                    // onBackgroundImageError: (_, __) {
                    //   const Icon(Icons.image, color: Colors.white,);
                    // },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16,),
            Column(
              children: [
                Text(
                    '${AuthUtility.userInfo.data?.firstName}',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                ),
                Text(
                  '${AuthUtility.userInfo.data?.email}',
                  //'${AuthUtility.userInfo.data?.firstName}',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
            }
          },
          icon: Icon(Icons.logout),
        ),
      ]
    );
  }
}

