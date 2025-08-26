import 'dart:async';

import 'package:flutter/services.dart';
import 'package:risco_image_gallery_saver/risco_image_gallery_saver_platform_interface.dart';

class RiscoImageGallerySaver {
  /// save image to Gallery
  /// imageBytes can't null
  /// return Map type
  /// for example:{"isSuccess":true, "filePath":String?}
  FutureOr<dynamic> saveImage(
    Uint8List imageBytes, {
    int quality = 80,
    String? name,
    bool isReturnImagePathOfIOS = false,
  }) async {
    return RiscoImageGallerySaverPlatform.instance.saveImage(
      imageBytes,
      quality: quality,
      name: name,
      isReturnImagePathOfIOS: isReturnImagePathOfIOS,
    );
  }

  /// Save the PNG，JPG，JPEG image or video located at [file] to the local device media gallery.
  Future saveFile(
    String file, {
    String? name,
    bool isReturnPathOfIOS = false,
  }) async {
    return RiscoImageGallerySaverPlatform.instance.saveFile(
      file,
      name: name,
      isReturnPathOfIOS: isReturnPathOfIOS,
    );
  }
}
