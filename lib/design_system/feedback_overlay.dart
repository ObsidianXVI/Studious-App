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

class FeedbackOverlay extends StatefulWidget {
  final Function()? dismiss;
  final List<CommentItem> comments;
  final String subRef;
  final void Function(VoidCallback) refresh;

  const FeedbackOverlay({
    required this.comments,
    required this.subRef,
    required this.refresh,
    this.dismiss,
    super.key,
  });

  @override
  createState() => FeedbackOverlayState();
}

class FeedbackOverlayState extends State<FeedbackOverlay> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> commentItems = [];
    final List<Widget> flaggedItems = [];
    for (int i = 0; i < widget.comments.length; i++) {
      (widget.comments[i].flagged ? flaggedItems : commentItems).addAll([
        CommentCard(
          commentItem: widget.comments[i],
          onFlagged: () async {
            final oldList =
                ((await db.collection('submissions').doc(widget.subRef).get())
                        .data()!['comments'] as List)
                    .cast<Map<String, dynamic>>();
            final List<Map<String, dynamic>> newList = oldList;
            newList[i] = CommentItem(
              user: widget.comments[i].user,
              content: widget.comments[i].content,
              flagged: true,
            ).toJson();
            await db
                .collection('submissions')
                .doc(widget.subRef)
                .update({'comments': newList});
            setState(() {});
          },
          onUpvote: () async {},
        ),
        const SizedBox(height: 10),
      ]);
    }
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: 700,
        decoration: BoxDecoration(
          color: StudiousTheme.white,
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
                commentItems.isEmpty
                    ? const Text('No comments yet!')
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('FLAGGED'),
                            const SizedBox(height: 10),
                            ...flaggedItems,
                            const SizedBox(height: 30),
                            ...commentItems,
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
