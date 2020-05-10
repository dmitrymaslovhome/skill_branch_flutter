import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({this.altDescription, this.userName, this.name, this.likeCount, this.isLiked, Key key}) : super(key: key);

  final String altDescription;
  final String userName;
  final String name;
  final int likeCount;
  final bool isLiked;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool isLiked = false;
  int likeCount = 10;
  String description = 'This is Flutter dash. I love him :)';
  String name = 'Kirill Adechenko';
  String userName = '@kaparray';

  @override
  void initState() {
    super.initState();
    if (widget.isLiked != null) isLiked = widget.isLiked;
    if (widget.likeCount != null) likeCount = widget.likeCount;
    if (widget.altDescription != null) description = widget.altDescription;
    if (widget.name != null) name = widget.name;
    if (widget.userName != null) userName = '@' + widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Photo(photoLink: kFlutterDash),
          _createDescription(description),
          _createUserData(name, userName),
          _createButtons(),
        ],
      ),
    );
  }

  Widget _createDescription(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.h3,
      ),
    );
  }

  Widget _createUserData(String name, String userName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: AppStyles.h1Black
              ),
              Text(
                userName,
                style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _createButtons() {
   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _createButton(
            _createLikeText(likeCount, isLiked),
            AppColors.white,
            onTap: () {
              setState(() {
                isLiked = !isLiked;
                if (isLiked) {
                  likeCount++;
                } else {
                  likeCount--;
                }
              });
            },
          ),
          _createButton(Text('Save', style: AppStyles.h4.copyWith(color: AppColors.white)), AppColors.dodgerBlue),
          _createButton(Text('Visit', style: AppStyles.h4.copyWith(color: AppColors.white)), AppColors.dodgerBlue),
        ],
      ),
    );
  }

  Widget _createLikeText(int likeCount, bool isLiked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
        SizedBox(width: 4),
        Text(likeCount.toString()),
      ],
    );
}

  Widget _createButton(Widget body, Color color, {void Function() onTap}) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: body,
        height: 36,
        width: 105,
      ),
      onTap: onTap,
    );
  }
}
