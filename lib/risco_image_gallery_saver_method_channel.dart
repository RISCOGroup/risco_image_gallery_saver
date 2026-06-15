import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'risco_image_gallery_saver_platform_interface.dart';

/// An implementation of [RiscoImageGallerySaverPlatform] that uses method channels.
class MethodChannelRiscoImageGallerySaver
    extends RiscoImageGallerySaverPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('risco_image_gallery_saver');

  /// save image to Gallery
  /// imageBytes can't null
  /// return Map type
  /// for example:{"isSuccess":true, "filePath":String?}
  @override
  FutureOr<dynamic> saveImage(
    Uint8List imageBytes, {
    int quality = 80,
    String? name,
    String? directoryPath,
    bool isReturnImagePathOfIOS = false,
  }) async {
    final result = await methodChannel
        .invokeMethod('saveImageToGallery', <String, dynamic>{
          'imageBytes': imageBytes,
          'quality': quality,
          'name': name,
          'directoryPath': directoryPath,
          'isReturnImagePathOfIOS': isReturnImagePathOfIOS,
        });
    return result;
  }

  /// Save the PNG，JPG，JPEG image or video located at [file] to the local device media gallery.
  @override
  Future saveFile(
    String file, {
    String? name,
    String? directoryPath,
    bool isReturnPathOfIOS = false,
  }) async {
    final result = await methodChannel
        .invokeMethod('saveFileToGallery', <String, dynamic>{
          'file': file,
          'name': name,
          'directoryPath': directoryPath,
          'isReturnPathOfIOS': isReturnPathOfIOS,
        });
    return result;
  }
}
