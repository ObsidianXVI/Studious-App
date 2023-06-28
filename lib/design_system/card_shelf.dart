part of studious.ds;

class CardShelf extends StatelessWidget {
  final String shelfName;
  final List<Widget> children;

  const CardShelf({
    required this.shelfName,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: shelfName,
      child: Column(
        children: [
          SearchBox(),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
