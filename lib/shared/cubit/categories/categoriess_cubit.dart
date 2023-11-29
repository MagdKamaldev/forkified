import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// Function to pick an image from the gallery
Future<File?> pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

// Function to upload the image with name and description to create a new category
Future<void> uploadCategory(File image, String name, String description) async {
  var request = http.MultipartRequest('POST', Uri.parse('your_upload_url'));
  request.fields['name'] = name;
  request.fields['description'] = description;
  request.files.add(await http.MultipartFile.fromPath('image', image.path));
  
  var response = await request.send();
  if (response.statusCode == 200) {
    // Upload successful
    print('Category uploaded successfully');
  } else {
    // Upload failed
    print('Failed to upload category');
  }
}
