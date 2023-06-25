part of studious.ds;

class RectTextButton extends StatelessWidget {
  final void Function() action;
  final String label;

  const RectTextButton({
    required this.action,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      style: TextButton.styleFrom(
        backgroundColor: StudiousTheme.purple,
      ),
      child: Container(
        width: 120,
        height: 40,
        color: StudiousTheme.purple,
        child: Text(
          label,
        ),
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  final void Function() action;
  final String label;
  final IconData iconData;
  final bool enabled;

  const IconTextButton({
    required this.action,
    required this.label,
    required this.iconData,
    required this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: StudiousTheme.purple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          border: enabled
              ? Border.all(
                  width: 1,
                  color: StudiousTheme.purple,
                )
              : null,
        ),
        child: TextButton(
          onPressed: enabled ? action : null,
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
              (states) => StudiousTheme.darkPurple.withOpacity(0.3),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Icon(
                iconData,
                color:
                    enabled ? StudiousTheme.purple : StudiousTheme.lightPurple,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  color: enabled
                      ? StudiousTheme.purple
                      : StudiousTheme.lightPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
