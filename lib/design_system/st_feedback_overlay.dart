part of studious.ds;

mixin OverlayTools<T extends StatefulWidget> on State<T> {
  OverlayEntry? overlayEntry;

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void addOverlay({
    required OverlayEntry overlay,
  }) {
    // Remove the existing OverlayEntry.
    removeOverlay();
    overlayEntry = overlay;
    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }
}

class StudentFeedbackOverlay extends OverlayEntry {
  final Function()? dismiss;

  StudentFeedbackOverlay({
    this.dismiss,
  }) : super(
          builder: (BuildContext context) {
            return Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                  color: StudiousTheme.white,
                  border: Border.all(
                    width: 2,
                    color: StudiousTheme.purple,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: const Offset(0, -4),
                      blurRadius: 28,
                    ),
                  ],
                ),
                child: Material(
                  color: StudiousTheme.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Feedback',
                              style: StudiousFont.viewTitle(),
                            ),
                            const Spacer(),
                            if (dismiss != null)
                              IconButton(
                                onPressed: () {
                                  dismiss();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 30,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
}
