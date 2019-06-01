import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/theme/theme.dart';
import 'package:flutterhackathon/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:photo_view/photo_view.dart';

class AppImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageURL;

  const AppImage({
    Key key,
    @required this.imageURL,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new CachedNetworkImage(
      imageUrl: imageURL,
      placeholder: (context, url) => ImagePlaceholderWidget(
            width: width ?? Sizes.defaultImageHeight,
            height: height ?? Sizes.defaultImageHeight,
          ),
      errorWidget: (context, url, error) => ImageErrorWidget(
            width: width ?? Sizes.defaultImageHeight,
            height: height ?? Sizes.defaultImageHeight,
          ),
      width: width ?? Sizes.defaultImageHeight,
      height: height ?? Sizes.defaultImageHeight,
      fit: BoxFit.fill,
    );
  }
}

class AppFullImage extends StatelessWidget {
  final String imageURL;

  const AppFullImage({
    Key key,
    @required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: CachedNetworkImageProvider(imageURL),
    );
  }
}

class ImageLayerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const ImageLayerWidget({Key key, this.width, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.black87.withOpacity(0.65),
      width: width ?? Sizes.defaultImageHeight,
      height: height ?? Sizes.defaultImageHeight,
    );
  }
}

class AppCircularImage extends StatefulWidget {
  final double radius;
  final String imageURL;

  const AppCircularImage({
    Key key,
    @required this.imageURL,
    this.radius,
  }) : super(key: key);

  @override
  _AppCircularImageState createState() => _AppCircularImageState();
}

class _AppCircularImageState extends State<AppCircularImage> {
  bool invalidURL = false;

  @override
  Widget build(BuildContext context) {
    if (widget.imageURL == null || widget.imageURL.isEmpty)
      return CircleAvatar(
        radius: widget.radius ?? Sizes.defaultImageRadius,
        backgroundColor: AppColors.charcoalGrey,
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: widget.radius ?? Sizes.defaultImageRadius,
        ),
      );

    return invalidURL
        ? CircleAvatar(
            radius: widget.radius ?? Sizes.defaultImageRadius,
            backgroundColor: AppColors.charcoalGrey,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: widget.radius ?? Sizes.defaultImageRadius,
            ),
          )
        : Stack(
            children: <Widget>[
              CircleAvatar(
                radius: widget.radius ?? Sizes.defaultImageRadius,
                backgroundColor: AppColors.charcoalGrey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: widget.radius ?? Sizes.s60,
                ),
              ),
              CircleAvatar(
                radius: widget.radius ?? Sizes.defaultImageRadius,
                backgroundImage: CachedNetworkImageProvider(widget.imageURL, errorListener: () {
                  setState(() {
                    invalidURL = true;
                  });
                  appLogs("Invalid Image URL :${widget.imageURL}");
                }),
                backgroundColor: Colors.transparent,
              ),
            ],
          );
  }
}

class ImagePlaceholderWidget extends StatelessWidget {
  final double width;
  final double height;

  const ImagePlaceholderWidget({Key key, @required this.width, @required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.placeholder),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ImageErrorWidget extends StatelessWidget {
  final double width;
  final double height;

  const ImageErrorWidget({Key key, @required this.width, @required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.placeholder),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class WordsMayaAvatar extends StatelessWidget {
  final double radius;

  const WordsMayaAvatar({Key key, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double outerRadius = 0;
    double innerRadius = 0;
    if (radius != null) {
      outerRadius = radius + 2;
      innerRadius = radius;
    } else {
      outerRadius = Sizes.s20 + 0.5;
      innerRadius = Sizes.s20;
    }

    return CircleAvatar(
      backgroundColor: AppColors.primary,
      radius: outerRadius,
      child: CircleAvatar(
        child: Image(
          image: AssetImage(Assets.placeholder),
          fit: BoxFit.fill,
        ),
        radius: innerRadius,
        backgroundColor: Colors.white,
      ),
    );
  }
}
