import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:risco_image_gallery_saver/risco_image_gallery_saver.dart';

import 'utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save image to gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    PermissionUtil.requestAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Save image to gallery"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 300,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: _saveLocalImage,
                  child: Text("Save Local Image"),
                ),
                width: 300,
                height: 44,
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: _saveNetworkImage,
                  child: Text("Save Network Image"),
                ),
                width: 300,
                height: 44,
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: _saveNetworkGifFile,
                  child: Text("Save Network Gif Image"),
                ),
                width: 300,
                height: 44,
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: _saveNetworkVideoFile,
                  child: Text("Save Network Video"),
                ),
                width: 300,
                height: 44,
              ),
            ],
          ),
        ));
  }

  _saveLocalImage() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
        await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result = await RiscoImageGallerySaver()
          .saveImage(byteData.buffer.asUint8List());
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
    final result = await RiscoImageGallerySaver()
        .saveFile(savePath, isReturnPathOfIOS: true);
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
}
