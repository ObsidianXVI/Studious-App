part of studious.ds;

class SearchBox extends StatelessWidget {
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
              ),
            ),
            const Spacer(),
            Center(
              child: Container(
                width: 30,
                height: 50,
                child: TextButton(
                  onPressed: () {},
                  child: const Center(
                    child: Icon(
                      Icons.search_rounded,
                      color: StudiousTheme.purple,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Center(
              child: Container(
                width: 35,
                height: 50,
                child: TextButton(
                  onPressed: () {},
                  child: const Center(
                    child: Icon(
                      Icons.filter_alt,
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
