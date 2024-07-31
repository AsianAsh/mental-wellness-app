// helper_functions.dart
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

/// Function to validate the first name and last name fields
bool validateNameFields(
    String firstName, String lastName, BuildContext context) {
  if (firstName.trim().isEmpty) {
    displaySnackBarMessage("First name cannot be empty", context);
    return false;
  }
  if (lastName.trim().isEmpty) {
    displaySnackBarMessage("Last name cannot be empty", context);
    return false;
  }
  if (firstName.length > 50) {
    displaySnackBarMessage("First name cannot exceed 50 characters", context);
    return false;
  }
  if (lastName.length > 50) {
    displaySnackBarMessage("Last name cannot exceed 50 characters", context);
    return false;
  }
  return true;
}

/// Function to validate the member-specific fields
bool validateMemberFields({
  required String email,
  required String password,
  required String confirmPassword,
  required BuildContext context,
}) {
  if (email.trim().isEmpty || !isEmail(email)) {
    displaySnackBarMessage("Please enter a valid email", context);
    return false;
  }
  if (password.trim().isEmpty || !isStrongPassword(password)) {
    displaySnackBarMessage(
        "Password must be at least 8 characters long and include a number and special character",
        context);
    return false;
  }
  if (password != confirmPassword) {
    displaySnackBarMessage("Passwords do not match", context);
    return false;
  }
  return true;
}

/// Function to validate the counsellor-specific fields
bool validateCounsellorFields({
  required String email,
  required String password,
  required String confirmPassword,
  required String bio,
  required String education,
  required String city,
  required String country,
  required String jobTitle,
  required String languages,
  required String experienceYears,
  required String linkedin,
  required BuildContext context,
}) {
  if (email.trim().isEmpty || !isEmail(email)) {
    displaySnackBarMessage("Please enter a valid email", context);
    return false;
  }
  if (password.trim().isEmpty || !isStrongPassword(password)) {
    displaySnackBarMessage(
        "Password must be at least 8 characters long and include a number and special character",
        context);
    return false;
  }
  if (password != confirmPassword) {
    displaySnackBarMessage("Passwords do not match", context);
    return false;
  }
  if (bio.trim().isEmpty) {
    displaySnackBarMessage("Bio cannot be empty", context);
    return false;
  }
  if (education.trim().isEmpty) {
    displaySnackBarMessage("Education cannot be empty", context);
    return false;
  }
  if (city.trim().isEmpty) {
    displaySnackBarMessage("City cannot be empty", context);
    return false;
  }
  if (jobTitle.trim().isEmpty) {
    displaySnackBarMessage("Job title cannot be empty", context);
    return false;
  }
  if (country.trim().isEmpty) {
    displaySnackBarMessage("Country cannot be empty", context);
    return false;
  }
  if (languages.trim().isEmpty || !isLanguagesValid(languages)) {
    displaySnackBarMessage(
        "Languages cannot be empty and must be valid", context);
    return false;
  }
  if (experienceYears.trim().isEmpty ||
      int.tryParse(experienceYears) == null ||
      int.parse(experienceYears) < 0 ||
      int.parse(experienceYears) > 50) {
    displaySnackBarMessage(
        "Experience years must be a valid number between 0 and 50", context);
    return false;
  }
  if (linkedin.trim().isEmpty) {
    displaySnackBarMessage("LinkedIn cannot be empty", context);
    return false;
  }
  if (linkedin.trim().isNotEmpty &&
      !isURL(linkedin, protocols: ['http', 'https'])) {
    displaySnackBarMessage(
        "Please enter a valid LinkedIn profile URL", context);
    return false;
  }
  return true;
}

/// Function to display a snack bar message
void displaySnackBarMessage(String message, BuildContext context,
    {Color backgroundColor = Colors.red}) {
  // Clear any existing SnackBar
  ScaffoldMessenger.of(context).clearSnackBars();

  // Show the new SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}

// Utility functions
bool isStrongPassword(String password) {
  // Password must be at least 8 characters long and include a number and special character
  final regex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
  return regex.hasMatch(password);
}

bool isLanguagesValid(String languages) {
  // Check that each language in the list is valid (basic check)
  List<String> languageList =
      languages.split(',').map((e) => e.trim()).toList();
  for (String language in languageList) {
    if (language.isEmpty || !RegExp(r'^[a-zA-Z\s]+$').hasMatch(language)) {
      return false;
    }
  }
  return true;
}

String addHttpIfNeeded(String url) {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    return 'https://$url';
  }
  return url;
}
