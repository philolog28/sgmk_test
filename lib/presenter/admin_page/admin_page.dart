import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_test/data/services/model/pizza_model.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/presenter/admin_page/bloc/admin_bloc.dart';
import 'package:sgmk_test/presenter/catalog_page/catalog_page.dart';
import 'package:sgmk_test/ui/colors.dart';
import 'package:sgmk_test/ui/styles.dart';
import 'package:sgmk_test/ui/widgets/plus_button.dart';
import 'package:sgmk_test/utils/string_generator.dart';

import '../../ui/widgets/leading_arrow_button.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/pizza_container_admin.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(
        pizzaRepository: context.read<PizzaRepository>(),
      )..add(const AdminLoadingRequested()),
      child: _AdminPageView(),
    );
  }
}

class _AdminPageView extends StatelessWidget {
  _AdminPageView({Key? key}) : super(key: key);

  final defaultPizza =
      Pizza(title:'', price: 0, inCart: false, quantity: 1, maxQuantity: 1);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is EasyMaskLoadingState) {
          CustomLoadingIndicator.startLoading;
        }
        if (state is StopEasyMaskLoadingState) {
          CustomLoadingIndicator.stopLoading;
        }
      },
      listenWhen: (_, c) =>
          c is EasyMaskLoadingState || c is StopEasyMaskLoadingState,
      buildWhen: (_, c) => c is AdminLoadingState || c is AdminLoadedState,
      builder: (context, state) {
        if (state is AdminLoadedState) {
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/scaffoldImage.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration:
                    BoxDecoration(gradient: UIGradient.gradientScaffold),
              ),
              GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    titleSpacing: 0,
                    leading: LeadingArrowButton(
                      onPressed: (BuildContext context) =>
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CatalogPage())),
                    ),
                    leadingWidth: 84,
                    actions: [
                      PlusButton(
                        onPressed: () => context
                            .read<AdminBloc>()
                            .add(AddNewPizza(pizza: defaultPizza)),
                        padding: const EdgeInsets.only(right: 24),
                      )
                    ],
                    title: Text(
                      'Add pizza',
                      style: UIStyles.appBarTextStyle(),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  body: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 24,right: 24,top: 36.5,bottom: 110),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PizzaContainerAdmin(
                          title: state.products[index].title,
                          price: state.products[index].price,
                          maxQuantity: state.products[index].maxQuantity,
                          onChangedTitle: (String? text) {
                            context.read<AdminBloc>().add(ChangePizzaTitle(
                                index: index,
                                newTitle: text!));
                          },
                          onChangedPrice: (String? text) {
                            context.read<AdminBloc>().add(ChangePizzaPrice(
                                index: index,
                              newPrice: text!,
                                ));
                          },
                          increment: (int? maxQuantity) {
                            context.read<AdminBloc>().add(IncrementMaxQuantity(
                                index: index,
                                newQuantity: maxQuantity!));
                          },
                          decrement: (int? maxQuantity) {
                            context.read<AdminBloc>().add(DecrementMaxQuantity(
                                index: index,
                                newQuantity: maxQuantity!));
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 32),
                      itemCount: state.products.length),
                  floatingActionButton: GestureDetector(
                    onTap: () => context
                        .read<AdminBloc>()
                        .add(Submit(products: state.products)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 19, bottom: 14, right: 24),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: UIColors.shadowsColor.withOpacity(0.08),
                                offset: const Offset(
                                  12,
                                  26,
                                ),
                                blurRadius: 50,
                                spreadRadius: 0)
                          ],
                            gradient: UIGradient.gradientPrimary,
                            borderRadius:
                               const BorderRadius.all(Radius.circular(24))),
                        child: Center(
                            child: Text(
                          'Save',
                          style: UIStyles.w700s18(color: UIColors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
