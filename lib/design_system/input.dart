part of studious.ds;

class SearchBox extends StatefulWidget {
  final void Function(String) onChangedCallback;
  final void Function(bool) onSortToggled;

  const SearchBox({
    required this.onChangedCallback,
    required this.onSortToggled,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => SearchBoxState();
}

class SearchBoxState extends State<SearchBox> {
  bool sortEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: StudiousTheme.purple),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextField(
                style: StudiousFont.body(),
                onChanged: widget.onChangedCallback,
              ),
            ),
            const Spacer(),
            const SizedBox(width: 5),
            Center(
              child: Container(
                width: 35,
                height: 50,
                color: sortEnabled
                    ? StudiousTheme.lightPurple
                    : Colors.transparent,
                child: TextButton(
                  onPressed: () {
                    sortEnabled = !sortEnabled;
                    widget.onSortToggled(sortEnabled);
                  },
                  child: const Center(
                    child: Icon(
                      Icons.sort,
                      color: StudiousTheme.purple,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
