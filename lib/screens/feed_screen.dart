import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                _buildItem(context,'Item$index'),
                Divider(
                  thickness: 2,
                  color: AppColors.mercury,
                ),
              ],
            );
          }),
    );
  }

  Widget _buildItem(BuildContext context,String itemTag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
            tag: itemTag,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => FullScreenImage(
                            heroTag: itemTag,
                          )));
                },
                child: Photo(photoLink: kFlutterDash),
              ),
            )),
        _buildPhotoMeta(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            itemTag + ' This is Flutter dash. I love him :)',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3.copyWith(color: AppColors.black),
          ),
        )
      ],
    );
  }

  Widget _buildPhotoMeta(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Kirill Adechenko', style: Theme.of(context).textTheme.headline2),
                  Text(
                    '@kaparray',
                    style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.manatee),
                  )
                ],
              ),
            ],
          ),
          LikeButton(10, true),
        ],
      ),
    );
  }
}
