import 'package:flutter/material.dart';

/// Function to display error messages in a dialog
void displayErrorMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      );
    },
  );
}

/// Function to validate the first name and last name fields
bool validateNameFields(
    String firstName, String lastName, BuildContext context) {
  if (firstName.trim().isEmpty) {
    displayErrorMessage("First name cannot be empty", context);
    return false;
  }
  if (lastName.trim().isEmpty) {
    displayErrorMessage("Last name cannot be empty", context);
    return false;
  }
  if (firstName.length > 50) {
    displayErrorMessage("First name cannot exceed 50 characters", context);
    return false;
  }
  if (lastName.length > 50) {
    displayErrorMessage("Last name cannot exceed 50 characters", context);
    return false;
  }
  return true;
}

/// Function to validate the counsellor-specific fields
bool validateCounsellorFields({
  required String bio,
  required String education,
  required String city,
  required String country,
  required String languages,
  required String experienceYears,
  required BuildContext context,
}) {
  if (bio.trim().isEmpty) {
    displayErrorMessage("Bio cannot be empty", context);
    return false;
  }
  if (education.trim().isEmpty) {
    displayErrorMessage("Education cannot be empty", context);
    return false;
  }
  if (city.trim().isEmpty) {
    displayErrorMessage("City cannot be empty", context);
    return false;
  }
  if (country.trim().isEmpty) {
    displayErrorMessage("Country cannot be empty", context);
    return false;
  }
  if (languages.trim().isEmpty) {
    displayErrorMessage("Languages cannot be empty", context);
    return false;
  }
  if (experienceYears.trim().isEmpty) {
    displayErrorMessage("Years of experience cannot be empty", context);
    return false;
  }
  if (int.tryParse(experienceYears) == null) {
    displayErrorMessage("Years of experience must be a number", context);
    return false;
  }
  return true;
}
