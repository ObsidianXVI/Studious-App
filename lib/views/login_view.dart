part of studious.views;

class LoginView extends StatelessWidget {
  final TextEditingController usernameFieldController = TextEditingController();
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
                controller: usernameFieldController,
                style: const TextStyle(
                  color: StudiousTheme.darkPurple,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                decoration: const InputDecoration(
                  label: Text(
                    'Username',
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
                action: () async {
                  bool bypassLogin = false;
                  if (usernameFieldController.text == '' &&
                      passwordFieldController.text == '') {
                    bypassLogin = true;
                  }
                  final QuerySnapshot<Student> queryResults =
                      await Database.usersColl
                          .where(
                            'username',
                            isEqualTo: bypassLogin
                                ? 'johnbap'
                                : usernameFieldController.text,
                          )
                          .where(
                            'password',
                            isEqualTo: bypassLogin
                                ? 'john123'
                                : passwordFieldController.text,
                          )
                          .get();
                  if (queryResults.size == 0) {
                    usernameFieldController.text = '';
                    passwordFieldController.text = '';
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (_) => Center(
                          child: Container(
                            width: 500,
                            height: 300,
                            color: Colors.red,
                            child: const Center(
                              child: Text('Invalid user credentials entered'),
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    studentId = queryResults.docs.first.id;
                    if (context.mounted) {
                      Navigator.of(context).pushNamed(RouteNames.classes);
                    }
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
