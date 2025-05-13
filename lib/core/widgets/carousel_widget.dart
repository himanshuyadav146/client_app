import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart'; // For caching network images

class CarouselWidget extends StatefulWidget {
  final List<String> imgList; // List of image URLs
  final Function(int) onTap; // Callback for when an item is tapped

  const CarouselWidget({super.key, required this.imgList, required this.onTap});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carousel
        CarouselSlider(
          options: CarouselOptions(
            height: 300, // Height of the carousel
            enlargeCenterPage: true, // Enlarges the center image
            autoPlay: true, // Auto-play the carousel
            aspectRatio: 16 / 9, // Aspect ratio of the images
            viewportFraction: 1, // Occupy full width
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          carouselController: _controller,
          items: widget.imgList
              .map(
                (item) => GestureDetector(
                  onTap: () => widget.onTap(_current), // Pass index on tap
                  child: CachedNetworkImage(
                    imageUrl: item,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    placeholder: (context, url) => Transform.scale(
                      scale: 1.5,
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              )
              .toList(),
        ),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
