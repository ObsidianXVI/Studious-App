part of studious.ds;

class ViewScaffold extends StatelessWidget {
  final String viewTitle;
  final Widget child;

  const ViewScaffold({
    required this.viewTitle,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: StudiousTheme.white,
        child: Center(
          child: Container(
            width: 1200,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    viewTitle,
                    style: StudiousFont.viewTitle(),
                  ),
                  const Divider(
                    height: 20,
                    color: StudiousTheme.purple,
                  ),
                  SingleChildScrollView(
                    child: child,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
