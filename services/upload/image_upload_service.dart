import 'dart:io';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadService extends GetxService {
  static ImageUploadService get to => Get.find();

  final ImagePicker _picker = ImagePicker();
  File? _userSelectedImage;
  XFile? _finalImageFile;

  ImageUploadService();

  Future<XFile?> getCameraImage({required bool cropEnabled}) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      return null;
    }
    _userSelectedImage = File(pickedFile.path);

    if (_userSelectedImage != null) {
      if (cropEnabled) {
        var tempCroppedFile = await _cropImage(image: _userSelectedImage!);
        if (tempCroppedFile != null) {
          _finalImageFile = await convertCroppedFileToXFile(tempCroppedFile);
        }
      } else {
        _finalImageFile = await convertFileToXFile(_userSelectedImage!);
      }
    }

    if (_finalImageFile != null) {
      return _finalImageFile;
    }

    return null;
  }

  Future<XFile?> getGalleyImage({required bool cropEnabled}) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    _userSelectedImage = File(pickedFile.path);

    if (cropEnabled) {
      if (_userSelectedImage != null) {
        var tempCroppedFile = await _cropImage(image: _userSelectedImage!);
        if (tempCroppedFile != null) {
          _finalImageFile = await convertCroppedFileToXFile(tempCroppedFile);
        }
      }
    } else {
      _finalImageFile = await convertFileToXFile(_userSelectedImage!);
    }

    if (_finalImageFile != null) {
      return _finalImageFile;
    }

    return null;
  }

  Future<CroppedFile?> _cropImage({required File image}) async {
    return await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      maxHeight: 512,
      maxWidth: 512,
    );
  }

  Future<XFile> convertCroppedFileToXFile(CroppedFile croppedFile) async {
    final String filePath = croppedFile.path;
    return XFile(filePath);
  }

  Future<XFile> convertFileToXFile(File file) async {
    final String filePath = file.path;
    return XFile(filePath);
  }
}
