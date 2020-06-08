import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    this.altDescription,
    this.userName,
    this.name,
    this.likeCount,
    this.isLiked,
    this.heroTag,
    Key key,
    this.photo,
    this.userPhoto,
  }) : super(key: key);

  final String altDescription;
  final String userName;
  final String name;
  final int likeCount;
  final bool isLiked;
  final String heroTag;
  final String photo;
  final String userPhoto;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }
}

class _StaggerAnimation extends StatelessWidget {
  _StaggerAnimation({
    Key key,
    this.controller,
    this.name,
    this.userName,
    this.userPhoto,
  })  : opacityAvatar = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.5, curve: Curves.ease),
        )),
        opacityUserName = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 1.0, curve: Curves.ease),
        ));

  final Animation<double> controller;
  final Animation<double> opacityAvatar;
  final Animation<double> opacityUserName;
  final String name;
  final String userName;
  final String userPhoto;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          Opacity(
            opacity: opacityAvatar.value,
            child: UserAvatar(userPhoto),
          ),
          SizedBox(width: 6),
          Opacity(
            opacity: opacityUserName.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(name, style: AppStyles.h1Black),
                Text(
                  userName,
                  style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  bool isLiked = false;
  int likeCount = 10;
  String description = 'This is Flutter dash. I love him :)';
  String name = 'Kirill Adechenko';
  String userName = '@kaparray';
  AnimationController _controller;
  String _heroTag;
  String photo = kFlutterDash;
  String userPhoto = 'https://skill-branch.ru/img/speakers/Adechenko.jpg';

  @override
  void initState() {
    super.initState();
    if (widget.isLiked != null) isLiked = widget.isLiked;
    if (widget.likeCount != null) likeCount = widget.likeCount;
    if (widget.altDescription != null) description = widget.altDescription;
    if (widget.name != null) name = widget.name;
    if (widget.userName != null) userName = '@' + widget.userName;
    if (widget.photo != null) photo = widget.photo;
    if (widget.userPhoto != null) userPhoto = widget.userPhoto;
    _heroTag = widget.heroTag;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          Hero(
            tag: _heroTag,
            child: Photo(photoLink: photo),
          ),
          _createDescription(description),
          _StaggerAnimation(
            controller: _controller.view,
            name: name,
            userName: userName,
            userPhoto: userPhoto,
          ),
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
          _createButton(
              Text('Save',
                  style: AppStyles.h4.copyWith(color: AppColors.white)),
              AppColors.dodgerBlue),
          _createButton(
              Text('Visit',
                  style: AppStyles.h4.copyWith(color: AppColors.white)),
              AppColors.dodgerBlue),
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
