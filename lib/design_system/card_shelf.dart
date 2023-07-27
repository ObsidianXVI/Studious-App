part of studious.ds;

class CardShelf extends StatelessWidget {
  final String shelfName;
  final List<Widget> children;
  final void Function(String) onChangedCallback;

  const CardShelf({
    required this.shelfName,
    required this.children,
    required this.onChangedCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: shelfName,
      child: Column(
        children: [
          SearchBox(
            onChangedCallback: onChangedCallback,
          ),
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
