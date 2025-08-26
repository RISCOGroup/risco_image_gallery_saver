import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'risco_image_gallery_saver_method_channel.dart';

abstract class RiscoImageGallerySaverPlatform extends PlatformInterface {
  /// Constructs a RiscoImageGallerySaverPlatform.
  RiscoImageGallerySaverPlatform() : super(token: _token);

  static final Object _token = Object();

  static RiscoImageGallerySaverPlatform _instance =
      MethodChannelRiscoImageGallerySaver();

  /// The default instance of [RiscoImageGallerySaverPlatform] to use.
  ///
  /// Defaults to [MethodChannelRiscoImageGallerySaver].
  static RiscoImageGallerySaverPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RiscoImageGallerySaverPlatform] when
  /// they register themselves.
  static set instance(RiscoImageGallerySaverPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

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
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Save the PNG，JPG，JPEG image or video located at [file] to the local device media gallery.
  Future saveFile(
    String file, {
    String? name,
    bool isReturnPathOfIOS = false,
  }) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
