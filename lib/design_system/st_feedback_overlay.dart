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

class StudentFeedbackOverlay extends StatefulWidget {
  final Function()? dismiss;
  final FeedbackItem feedbackItem;

  const StudentFeedbackOverlay({
    required this.feedbackItem,
    this.dismiss,
    super.key,
  });

  @override
  createState() => StudentFeedbackOverlayState();
}

class StudentFeedbackOverlayState extends State<StudentFeedbackOverlay> {
  StudentCommentCard? activeComment;

  @override
  Widget build(BuildContext context) {
    final List<Widget> commentItems = [];
    for (CommentItem commentItem in widget.feedbackItem.comments) {
      commentItems.addAll([
        StudentCommentCard(
          commentItem: commentItem,
          onSelectCallback: (StudentCommentCard commentItem) {
            activeComment = commentItem;
            setState(() {});
          },
          onUnselectCallback: () {
            activeComment = null;
            setState(() {});
          },
        ),
        const SizedBox(height: 10),
      ]);
    }
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: activeComment == null ? 700 : 900,
        decoration: BoxDecoration(
          color: StudiousTheme.white,
          /* border: Border.all(
            width: 2,
            color: StudiousTheme.purple,
          ), */
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
                    if (widget.dismiss != null)
                      IconButton(
                        onPressed: () {
                          widget.dismiss!();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                if (activeComment == null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: commentItems,
                      ),
                    ),
                  ),
                if (activeComment != null)
                  Column(
                    children: [
                      activeComment!,

                      /// Content of highlighted material
                      // Expanded(child: SingleChildScrollView(child: ,)),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
