part of '../product_page.dart';

class _ImagesSlider extends StatelessWidget {
  final ProductModel product;
  final ValueChanged<int> onIndexChanged;
  final int imageIndex;
  final VoidCallback? onImageViewTap;

  const _ImagesSlider(
      {Key? key,
        required this.product,
        required this.onIndexChanged,
        required this.imageIndex,
        this.onImageViewTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width/3*4,
          child: Stack(
            children: [
             PinchZoom(
                    resetDuration: const Duration(milliseconds: 200),
                    maxScale: 2.5,
                    // onZoomStart: (){print('Start zooming');},
                    // onZoomEnd: (){print('Stop zooming');},
                    child: Image.network(product.images![imageIndex]),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                      onTap: ()=> Navigator.pop(context),
                      child: const Icon(Icons.cancel))),
            ],
          ),
        ),
      ],
    );
  }
}
