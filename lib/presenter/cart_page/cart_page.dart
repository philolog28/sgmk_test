import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/ui/colors.dart';
import 'package:sgmk_test/ui/styles.dart';

import '../../ui/widgets/leading_arrow_button.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/pizza_container_cart.dart';
import 'bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      CartBloc(
        pizzaRepository: context.read<PizzaRepository>(),
      )
        ..add(const CartLoadingRequested()),
      child: const _CartPageView(),
    );
  }
}

class _CartPageView extends StatelessWidget {
  const _CartPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
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
      buildWhen: (_, c) => c is CartLoadingState || c is CartLoadedState,
      builder: (context, state) {
        if (state is CartLoadedState) {
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Image.asset(
                  'assets/images/scaffoldImage.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration:
                BoxDecoration(gradient: UIGradient.gradientScaffold),
              ),
              Scaffold(
                floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: LeadingArrowButton(
                      onPressed: (BuildContext context) =>
                          Navigator.of(context).pop()),
                  leadingWidth: 84,
                  titleSpacing: 0,
                  title: Text(
                    'Order details',
                    style: UIStyles.appBarTextStyle(),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                    const EdgeInsets.only(left: 24, right: 24, top: 36.5),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return PizzaContainerCart(
                        title: state.cart[index].title,
                        price: state.cart[index].price,
                        quantity: state.cart[index].quantity,
                        decrement: (int? quantity) {
                          context.read<CartBloc>().add(
                              DecrementPizzaQuantityRequested(
                                  index: index, newQuantity: quantity!));
                        },
                        increment: (int? quantity) {
                          if (quantity! <= state.cart[index].maxQuantity!) {
                            context.read<CartBloc>().add(
                                IncrementPizzaQuantityRequested(
                                    newQuantity: quantity, index: index));
                          } else {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              // false = user must tap button, true = tap outside dialog
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: const Text('Pizza'),
                                  content: const Text('you can`t add more'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Ok', style: UIStyles.w600s18(),),
                                      onPressed: () {
                                        Navigator.of(dialogContext)
                                            .pop(); // Dismiss alert dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 32),
                    itemCount: state.cart.length),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(
                      left: 19, bottom: 14, right: 24),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 149,
                    decoration: BoxDecoration(
                        gradient: UIGradient.gradientPrimary,
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
                        borderRadius:
                        const BorderRadius.all(Radius.circular(24))),
                    child: Column(
                      children: [
                        const SizedBox(height: 24,),
                        const Divider(
                          height: 1,
                          color: UIColors.white,
                          indent: 48,
                          endIndent: 48,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24,
                              vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: UIStyles.w400s16White(),),
                              Text(
                                ' \$${state.totalPrice.toStringAsFixed(0)}',
                                style: UIStyles.w600s20White(),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24,
                              left: 24,
                              right: 24),
                          child: SizedBox(
                            height: 55,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: CupertinoButton(
                              onPressed: () => null,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(32)),
                              color: UIColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Text('Place my order',
                                style: UIStyles.w600s18(
                                    color: UIColors.primaryColor),),

                            ),
                          ),
                        ),
                      ],
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
