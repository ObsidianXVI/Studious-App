part of studious.views;

class LaunchView extends StatelessWidget {
  const LaunchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: StudiousTheme.purple,
        child: Center(
          child: Column(
            children: [
              Text(
                "Studious",
                style: StudiousFont.megaTitle(
                  color: StudiousTheme.white,
                ),
              ),
              LoginView(),
              const SizedBox(height: 20),
              RectTextButton(
                label: 'Student',
                action: () {
                  Navigator.pushNamed(context, NavRoutes.students_classes);
                },
              ),
              const SizedBox(height: 20),
              RectTextButton(
                label: 'Teacher',
                action: () {
                  Navigator.pushNamed(context, NavRoutes.students_classes);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
