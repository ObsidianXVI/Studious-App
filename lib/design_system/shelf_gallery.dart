part of studious.ds;

class ShelfGallery extends StatelessWidget {
  final List<Shelf> shelves;
  final double width;
  final double height;
  const ShelfGallery({
    required this.width,
    required this.height,
    required this.shelves,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> galleryItems = [];
    for (int i = 0; i < shelves.length; i++) {
      galleryItems.addAll([
        shelves[i],
        const SizedBox(width: 20),
      ]);
    }
    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20),
          children: galleryItems,
        ),
      ),
    );
  }
}
