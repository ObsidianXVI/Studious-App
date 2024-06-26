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
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          TextButton(
            child: const Icon(
              Icons.home,
              color: StudiousTheme.darkPurple,
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const Material(child: LaunchView()))),
          ),
          TextButton(
            child: const Icon(
              Icons.list_alt,
              color: StudiousTheme.darkPurple,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteNames.classes),
          ),
          TextButton(
            child: const Icon(
              Icons.history,
              color: StudiousTheme.darkPurple,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteNames.activity),
          ),
        ],
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
