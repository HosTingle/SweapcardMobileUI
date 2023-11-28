import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/Profile/profilemenu.dart';
import 'package:untitled4/Profile/updateprofile.dart';
import 'package:untitled4/Service/user_Service.dart';
import 'package:untitled4/provider/user_prodiver.dart';

import '../Model/Users.dart';



class MainPag extends StatefulWidget {
  final Users user;

  const MainPag({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPag> {
  userservice user=userservice();
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery
          .of(context)
          .size;

      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 30,),
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child:  Image(image: AssetImage("${widget.user.imagePath}")),),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                      child: const FaIcon(FontAwesomeIcons.userLarge,color: Colors.black,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(widget.user.username!, style: TextStyle(
                color: Colors.black,
                fontSize: 30

              )),
              Text("${widget.user.name} ${widget.user.surname}", style: TextStyle(
                  color: Colors.black
              )),
              const SizedBox(height: 20),
              Text("${widget.user.description}", style: TextStyle(
                  color: Colors.black
              )),
              const Divider(height: 20,color: Colors.black),
              const SizedBox(height: 30),

              /// -- MENU
              ProfileMenuWidget(title: "Edit Profile",icon:Icons.account_box,  onPress: ()async {Users result=await Get.to(() => UpdateProfileScreen(),arguments: widget.user);
              setState(() {
                widget.user.name=result.name;
                widget.user.surname=result.surname;
                widget.user.username=result.username;
              });
              } ),
              ProfileMenuWidget(title: "Settings", icon:Icons.settings , onPress: () {},),
              ProfileMenuWidget(title: "Premium Account", icon:Icons.verified_user_outlined, onPress: () {},),
              const Divider(height: 20,color: Colors.black),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon:Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon:Icons.arrow_back,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(onPressed: () => {}, child: const Text("No")),
                    );
                  }),
              SizedBox(height: 120)
            ],
          ),
        ),
      ),
    );
  }
}