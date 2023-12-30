part of studious.ds;

class CardShelf<T> extends StatefulWidget {
  final String shelfName;
  final List<T> data;
  final Widget Function(T) createWidget;

  /// Defines the function to decide whether the search term should trigger
  /// a match for a given item [T]
  final bool Function(String, T) doesMatch;

  const CardShelf({
    required this.shelfName,
    required this.data,
    required this.createWidget,
    required this.doesMatch,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _CardShelfState<T>();
}

class _CardShelfState<T> extends State<CardShelf<T>> {
  late Iterable<T> filteredItems = widget.data;

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: widget.shelfName,
      child: Column(
        children: [
          SearchBox(
            onChangedCallback: (String newVal) {
              if (newVal.isEmpty) {
                setState(() {
                  filteredItems = widget.data;
                });
              } else {
                setState(() {
                  filteredItems =
                      widget.data.where((e) => widget.doesMatch(newVal, e));
                });
              }
            },
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Column(
              children: [
                for (T t in filteredItems) ...[
                  widget.createWidget(t),
                  const SizedBox(height: 10),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
