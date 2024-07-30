import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_wellness_app/controllers/update_profile_controller.dart';
import 'package:mental_wellness_app/widgets/edit_profile_textfield.dart';
import 'package:country_picker/country_picker.dart';

class UpdateProfileScreen extends StatelessWidget {
  final UpdateProfileController _controller =
      Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text('Edit Profile',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  Obx(() => SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _controller.profilePicUrl.value != null &&
                                  _controller.profilePicUrl.value!.isNotEmpty
                              ? Image.network(
                                  _controller.profilePicUrl.value!,
                                  fit: BoxFit.cover,
                                )
                              : const Image(
                                  image: AssetImage(
                                      'assets/images/default_profile.png')),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _controller.pickImage,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.indigo[500]),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    EditProfileTextField(
                      labelText: 'First Name',
                      prefixIcon: Icons.person,
                      controller: _controller.firstNameController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'Last Name',
                      prefixIcon: Icons.person,
                      controller: _controller.lastNameController,
                    ),
                    const SizedBox(height: 10),
                    EditProfileTextField(
                      labelText: 'Bio',
                      prefixIcon: Icons.description,
                      controller: _controller.bioController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 10),

                    // Country Picker
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            _controller.setSelectedCountry(country.name);
                          },
                        );
                      },
                      child: Obx(() => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.indigo[700],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  _controller.selectedCountry.value
                                              ?.isNotEmpty ==
                                          true
                                      ? _controller.selectedCountry.value!
                                      : 'Select Country',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          )),
                    ),

                    const SizedBox(height: 30),

                    // -- Form Submit Button
                    Obx(() => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _controller.isDataChanged.value
                                ? () => _controller.updateMemberDetails(context)
                                : null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _controller.isDataChanged.value
                                    ? Colors.amber
                                    : Colors.grey,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: const Text('Save Changes',
                                style: TextStyle(color: Colors.indigo)),
                          ),
                        )),
                    const SizedBox(height: 30),

                    // -- Created Date
                    Row(
                      children: [
                        Obx(() => Text.rich(
                              TextSpan(
                                text: 'Joined ',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                                children: [
                                  TextSpan(
                                      text: _controller.joinedDate.value,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
