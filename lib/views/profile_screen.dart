import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/views/login_screen.dart';
import 'package:mental_wellness_app/views/update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes default go back button
        title: Text('Profile',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {},
              iconSize: 25.0,
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode)),
          Container(
            // width: 38.0, // Adjust the width as needed
            // height: 38.0, // Adjust the height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.indigo[50]?.withOpacity(0.1),
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              iconSize: 28.0, // Adjust the icon size as needed
              icon: const Icon(Icons.close),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // // Title, back button, dark mode
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IconButton(
              //         onPressed: () => Get.back(),
              //         icon: Icon(Icons.arrow_left)),
              //     Text('Profile',
              //         style: Theme.of(context).textTheme.headlineMedium),
              //     IconButton(
              //         onPressed: () {},
              //         icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode))
              //   ],
              // ),
              // const SizedBox(height: 20),

              // Profile Image
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('assets/images/gong_yoo.jpg'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.indigo[50]),
                      child: const Icon(
                        Icons.create_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text('Ash Char',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),

              Text('ashchar111@gmail.com',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),

              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[50],
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Edit Profile',
                      style: TextStyle(color: Colors.black)),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings",
                  icon: Icons.settings,
                  textColor: Colors.white,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Billing Details",
                  icon: Icons.wallet,
                  textColor: Colors.white,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "User Management",
                  icon: Icons.manage_accounts,
                  textColor: Colors.white,
                  onPress: () {}),

              const Divider(),
              const SizedBox(height: 10),

              ProfileMenuWidget(
                  title: "Information",
                  icon: Icons.info,
                  textColor: Colors.white,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
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
                      confirm:
                          //Expanded(
                          //child:
                          ElevatedButton(
                        // Template onPress code
                        // onPressed: () =>
                        //     // AuthenticationRepository.instance.logout(),

                        // Navigate to login screen
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            side: BorderSide.none),
                        child: const Text("Yes"),
                      ),
                      //),

                      cancel: OutlinedButton(
                          onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.indigo[50]?.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.indigo[50]),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(Icons.arrow_forward_ios,
                  size: 18.0, color: Colors.indigo[50]))
          : null,
    );
  }
}
