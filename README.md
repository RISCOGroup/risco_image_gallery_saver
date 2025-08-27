# risco_image_gallery_saver

We use the `image_picker` plugin to select images from the Android and iOS image library, but it can't save images to the gallery. This plugin can provide this feature.

## Usage

To use this plugin, add `risco_image_gallery_saver` as a dependency in your pubspec.yaml file. For example:
```yaml
dependencies:
  risco_image_gallery_saver: '^0.1.0'
```

## iOS
Your project need create with swift.
Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:
 * NSPhotoLibraryAddUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Additions Usage Description in the visual editor
 
 ##  Android
 You need to ask for storage permission to save an image to the gallery. You can handle the storage permission using [flutter_permission_handler](https://github.com/BaseflowIT/flutter-permission-handler).
 In Android version 10, Open the manifest file and add this line to your application tag
 ```
 <application android:requestLegacyExternalStorage="true" .....>
 ```

## Example
Saving an image from the internet, quality and name is option
``` dart
_saveLocalImage() async {
  RenderRepaintBoundary boundary =
  _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage();
  ByteData? byteData =
  await (image.toByteData(format: ui.ImageByteFormat.png));
  if (byteData != null) {
    final result =
    await RiscoImageGallerySaver().saveImage(byteData.buffer.asUint8List());
    print(result);
    Utils.toast(result.toString());
  }
}

_saveNetworkImage() async {
  var response = await Dio().get(
      "https://raw.githubusercontent.com/RISCOGroup/risco_image_gallery_saver/main/riscoassets/icon.png",
      options: Options(responseType: ResponseType.bytes));
  final result = await RiscoImageGallerySaver().saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: "hello");
  print(result);
  Utils.toast("$result");
}
```

Saving file(ig: video/gif/others) from the internet
``` dart
_saveNetworkGifFile() async {
  var appDocDir = await getTemporaryDirectory();
  String savePath = appDocDir.path + "/temp.gif";
  String fileUrl =
      "https://raw.githubusercontent.com/RISCOGroup/risco_image_gallery_saver/refs/heads/main/riscoassets/icon.gif";
  await Dio().download(fileUrl, savePath);
  final result =
  await RiscoImageGallerySaver().saveFile(savePath, isReturnPathOfIOS: true);
  print(result);
  Utils.toast("$result");
}

_saveNetworkVideoFile() async {
  var appDocDir = await getTemporaryDirectory();
  String savePath = appDocDir.path + "/temp.mp4";
  String fileUrl =
      "https://github.com/RISCOGroup/risco_image_gallery_saver/raw/refs/heads/main/riscoassets/iRiscoSplash.mp4";
  await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
    print((count / total * 100).toStringAsFixed(0) + "%");
  });
  final result = await RiscoImageGallerySaver().saveFile(savePath);
  print(result);
  Utils.toast("$result");
}
```
