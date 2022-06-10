import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/presenter/admin_page/admin_page.dart';
import 'package:sgmk_test/presenter/cart_page/cart_page.dart';
import 'package:sgmk_test/presenter/catalog_page/bloc/catalog_bloc.dart';
import 'package:sgmk_test/ui/colors.dart';
import 'package:sgmk_test/ui/styles.dart';
import 'package:sgmk_test/ui/widgets/cart_button.dart';
import 'package:sgmk_test/ui/widgets/pizza_container_catalog.dart';
import 'package:sgmk_test/ui/widgets/route_to_admin_button.dart';

import '../../ui/widgets/loading_indicator.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogBloc(
        pizzaRepository: context.read<PizzaRepository>(),
      )..add(const CatalogLoadingRequested()),
      child: const _CatalogPageView(),
    );
  }
}

class _CatalogPageView extends StatelessWidget {
  const _CatalogPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogBloc, CatalogState>(
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
      buildWhen: (_, c) => c is CatalogLoadingState || c is CatalogLoadedState,
      builder: (context, state) {
        if (state is CatalogLoadedState) {
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
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  actions: [
                    CartButton(
                      onPressed: (BuildContext context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage())),
                      padding: const EdgeInsets.only(right: 50),
                    ),
                    RouteToAdminButton(
                      padding: const EdgeInsets.only(right: 36),
                      onPressed: (BuildContext context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminPage())),
                    ),
                  ],
                  title: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Pizza Market',
                      style: UIStyles.appBarTextStyle(),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 111),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return PizzaContainerCatalog(
                        title: state.catalog[index].title,
                        price: state.catalog[index].price,
                        onTap: (BuildContext context) {
                          context.read<CatalogBloc>().add(
                              AddPizzaToCartRequested(
                                  index: index));
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 32),
                    itemCount: state.catalog.length),
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
