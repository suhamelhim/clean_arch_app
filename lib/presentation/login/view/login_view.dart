
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mena1/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:mena1/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:mena1/presentation/resources/assets_manager.dart';
import 'package:mena1/presentation/resources/color_manager.dart';
import 'package:mena1/presentation/resources/strings_manager.dart';
import 'package:mena1/presentation/resources/value_manager.dart';

import '../../../app/app_refs.dart';
import '../../../app/di.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences=instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _userNameController.addListener(() {
      _viewModel.setPassword(_userNameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setUserName(_passwordController.text);
    });
    _viewModel.isUserLoggedInStreamController.stream.listen((isLoggedIn) {
      if (isLoggedIn){
        _appPreferences.isUserLoggedIn();
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }


    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<StateFlow>(
        stream: _viewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context, _getContactWidget(), () {
            _viewModel.login();

          })?? _getContactWidget();
        },
      ),
    );
  }

  Widget _getContactWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Center(
                      child: Image(image: AssetImage(ImagesAssets.splashLogo))),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.username,
                              label: const Text(AppStrings.username),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.usernameError),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password,
                              label: const Text(AppStrings.password),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.password),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? true)
                              ? () {
                                _viewModel.login();
                              }   :null
                              ,
                              child: const Text(AppStrings.login)),
                        );
                      },
                    ),
                  ),
                   Padding(
                      padding: const EdgeInsets.only(
                    top: AppSize.s8,
                    left: AppSize.s28,
                    right: AppSize.s28,

                  ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         TextButton(
                             onPressed: (){
                               Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                             },
                             child: Text(AppStrings.forgetPassword,
                             style: Theme.of(context).textTheme.titleMedium,)),
                         TextButton(
                             onPressed: (){
                               Navigator.pushReplacementNamed(context, Routes.registerRoute);
                             },
                             child: Text(AppStrings.register,
                               style: Theme.of(context).textTheme.titleMedium,))
                       ],
                     ),
                   ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
