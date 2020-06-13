import 'dart:io';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              (settings.arguments as FullScreenImageArguments);
          final route = FullScreenImage(
            altDescription: args.altDescription,
            userName: args.userName,
            name: args.name,
            likeCount: args.likeCount,
            isLiked: args.isLiked,
            heroTag: args.heroTag,
            key: args.key,
            photo: args.photo,
            userPhoto: args.userPhoto,
          );
          if (Platform.isAndroid) {
            return MaterialPageRoute(builder: (context) => route, settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(builder: (context) => route, settings: args.routeSettings);
          }
        }
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppStyles.buildAppTextTheme(),
      ),
      home: Home(Connectivity().onConnectivityChanged),
    );
  }
}
