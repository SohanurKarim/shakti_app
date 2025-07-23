import 'package:flutter/material.dart';
import 'package:shakti_contact/views/profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // appBar: AppBar(
      //   centerTitle: false,
      //   //elevation: 0,
      //   backgroundColor: Colors.blue,
      //   foregroundColor: Colors.white,
      //   title: const Text("Profile"),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.settings_outlined),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Your Profile Info",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),
                  ),
                ),
              ),
              const ProfilePic(image: "https://i.postimg.cc/cCsYDjvj/user-2.png"),
              Text(
                "Sohanur Karim",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(height: 16.0 * 2),
              const Info(
                infoKey: "User ID",
                info: "@annette.me",
              ),
              const Info(
                infoKey: "Location",
                info: "Mymensingh, Bangladesh",
              ),
              const Info(
                infoKey: "Phone",
                info: "01847099613",
              ),
              const Info(
                infoKey: "Email Address",
                info: "mskarim@shakti.org.bd",
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProfileScreen()));
                    },
                    child: const Text("Edit profile"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
          Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
