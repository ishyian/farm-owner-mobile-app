import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/core/auth/enums/auth_view_enums.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_provider.dart';
import 'package:weqaa/core/auth/widgets/auth_view/login_widget.dart';
import 'package:weqaa/core/auth/widgets/auth_view/otp_widget.dart';
import 'package:weqaa/core/auth/widgets/auth_view/register_widget.dart';
import 'package:weqaa/core/auth/widgets/common/auth_widget.dart';
import 'package:weqaa/core/common/widgets/common/app_animated_switcher.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Form(
            onChanged: () {
              authProvider.reNotifyWidget();
            },
            key: authProvider.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: AuthWidget(
              child: AppAnimatedSwitcher(
                  isForward: authProvider.previousSate != null,
                  child: getWidget(authProvider.authViewEnum)),
            ),
          );
        },
      ),
    );
  }

  Widget getWidget(AuthViewEnum type) {
    if (type == AuthViewEnum.login) {
      return const LoginWidget();
    } else if (type == AuthViewEnum.register) {
      return const RegisterWidget();
    } else if (type == AuthViewEnum.otp) {
      return const OtpWidget();
    }
    return const LoginWidget();
  }
}
