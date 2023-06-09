part of studious.views;

class LoginView extends StatelessWidget {
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 500,
        decoration: BoxDecoration(
          color: StudiousTheme.lightPurple,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  color: StudiousTheme.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: emailFieldController,
                style: const TextStyle(
                  color: StudiousTheme.darkPurple,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                decoration: const InputDecoration(
                  label: Text(
                    'Email Address',
                    style: TextStyle(
                      color: StudiousTheme.darkPurple,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: StudiousTheme.darkPurple),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: passwordFieldController,
                obscureText: true,
                style: const TextStyle(
                  color: StudiousTheme.darkPurple,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                decoration: const InputDecoration(
                  label: Text(
                    'Password',
                    style: TextStyle(
                      color: StudiousTheme.darkPurple,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: StudiousTheme.darkPurple),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              RectTextButton(
                label: 'Log in',
                action: () {
                  // dev purposes only
                  if (emailFieldController.value.text.contains('te')) {
                    SessionConfigs.studentMode = false;
                    Navigator.of(context).pushNamed(NavRoutes.classes);
                  } else if (emailFieldController.value.text.contains('st')) {
                    SessionConfigs.studentMode = true;
                    Navigator.of(context).pushNamed(NavRoutes.classes);
                  } else {
                    emailFieldController.clear();
                    passwordFieldController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
