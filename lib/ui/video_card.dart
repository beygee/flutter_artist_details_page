import 'package:flutter/material.dart';
import 'package:blurry_artist_details_page/data/models.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  VideoCard(this.video);

  BoxDecoration _buildShadowAndRoundedCorners() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.4),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          spreadRadius: 2.0,
          blurRadius: 10.0,
          color: Colors.black26,
        )
      ],
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Image.asset(video.thumbnail),
          Positioned(
            bottom: 12.0,
            right: 12.0,
            child: _buildPlayButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: Text(video.title,
          style: TextStyle(color: Colors.white.withOpacity(0.85))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildShadowAndRoundedCorners(),
      width: 175.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 3, child: _buildThumbnail()),
          Flexible(flex: 2, child: _buildInfo()),
        ],
      ),
    );
  }

  Widget _buildPlayButton() {
    return Material(
      color: Colors.black87,
      type: MaterialType.circle,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () async {
          if (await canLaunch(video.url)) {
            await launch(video.url);
          }
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
