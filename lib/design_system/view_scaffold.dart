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
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            viewTitle,
            style: StudiousFont.appBarTitle(),
          ),
          iconTheme: const IconThemeData(color: StudiousTheme.white),
          backgroundColor: StudiousTheme.darkPurple,
          shadowColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: StudiousTheme.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                top: 10,
                bottom: 40,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
