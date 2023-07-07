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
          ),
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
/*                   Text(
                    viewTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: StudiousFont.viewTitle(),
                  ), */
/*                 const Divider(
                  height: 20,
                  color: StudiousTheme.purple,
                ), */
                  const SizedBox(height: 20),
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
