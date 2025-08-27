example/lib/main.dart

```dart
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
