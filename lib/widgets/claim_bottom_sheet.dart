import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildItem(context, 'adult'),
        _buildItem(context, 'harm'),
        _buildItem(context, 'bully'),
        _buildItem(context, 'spam'),
        _buildItem(context, 'copyright'),
        _buildItem(context, 'hate'),
      ],
    );
  }

  Widget _buildItem(BuildContext context, String text) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text.toUpperCase(),
          ),
        ),
      ),
    );
  }
}
