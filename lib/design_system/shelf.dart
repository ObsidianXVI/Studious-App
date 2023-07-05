part of studious.ds;

class Shelf extends StatelessWidget {
  final String title;
  final List<Widget> cards;
  final Color? color;
  final double width;
  final double height;

  const Shelf({
    required this.title,
    required this.cards,
    required this.width,
    required this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> shelfItems = [];
    for (int i = 0; i < cards.length; i++) {
      shelfItems.addAll([
        cards[i],
        const SizedBox(height: 5),
      ]);
    }
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color?.withOpacity(0.2),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              top: 80,
              left: 10,
              right: 10,
              child: Container(
                child: ListView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(bottom: 10),
                  children: shelfItems,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: width,
                height: 30,
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
