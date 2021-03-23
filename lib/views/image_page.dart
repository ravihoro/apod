import 'package:stacked/stacked.dart';
import 'package:apod/views/home_viewmodel.dart';
import '../model/image_data.dart';
import 'package:flutter/material.dart';
import '../enums/viewstate.dart';

class ImagePage extends ViewModelWidget<HomeViewModel> {
  const ImagePage({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return model.state == ViewState.Loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : model.imageData == null
            ? _errorFetchingImage()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _image(model.imageData, context),
                    _imageDescription(model.imageData),
                  ],
                ),
              );
  }

  Widget _errorFetchingImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error),
        SizedBox(
          height: 5.0,
        ),
        Text('Unable to fetch image'),
      ],
    );
  }

  Widget _image(ImageData imageData, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: screenWidth > 600 ? screenWidth * 0.75 : screenWidth,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          // child: CachedNetworkImage(
          //   imageUrl: imageData.url,
          //   fit: BoxFit.fitWidth,
          //   progressIndicatorBuilder: (context, url, downloadProgress) {
          //     return Center(
          //       child: CircularProgressIndicator(
          //         value: downloadProgress.progress,
          //       ),
          //     );
          //   },
          //   errorWidget: (context, url, error) {
          //     return Icon(Icons.error);
          //   },
          // ),
          child: Image.network(
            imageData.url,
            errorBuilder: (context, exception, stackTrace) {
              print(exception);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    SizedBox(
                      height: 5.0,
                    ),
                    imageData.mediaType == 'video'
                        ? Text('Unable to play video')
                        : Text('Unable to display image'),
                  ],
                ),
              );
            },
            fit: BoxFit.fitWidth,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _imageDescription(ImageData imageData) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            imageData.title ?? "N/A",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'By: ${imageData.copyright ?? "N/A"}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Date: ${imageData.date ?? "N/A"}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Description: ${imageData.explanation ?? "N/A"}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
