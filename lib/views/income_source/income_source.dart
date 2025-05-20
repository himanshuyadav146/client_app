import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/custom_grid_widget.dart';
import 'package:client_app/data/models/income_source/sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/income_source/income_source_bloc.dart';
import '../../main.dart';

class IncomeSourceView extends StatefulWidget {
  IncomeSourceView({super.key});

  @override
  State<IncomeSourceView> createState() => _IncomeSourceViewState();
}

class _IncomeSourceViewState extends State<IncomeSourceView> {

  // State variable to track the selected category
  Set<IncomeSource> _selectedCategory = {};

  late final IncomeSourceBloc _incomeSourceBloc;

  @override
  void initState() {
    super.initState();
    _incomeSourceBloc = getIt<IncomeSourceBloc>();
    if (_incomeSourceBloc.state is! IncomeSourceLoadedState) {
      _incomeSourceBloc.add(LoadIncomeSourcesEvent());
    }
  }

  @override
  void dispose() {
    _incomeSourceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _incomeSourceBloc,
      child: BlocListener<IncomeSourceBloc, IncomeSourceState>(
        listener: (context, state) {
          if (state is IncomeSourceErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: CoreScaffold(
          appBarBackgroundColor: Theme.of(context).primaryColor,
          appBarForegroundColor: Colors.white,
          showBackButton: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  BlocBuilder<IncomeSourceBloc, IncomeSourceState>(
                    builder: (context, state) {
                      if (state is IncomeSourceLoadingState ||
                          state is IncomeSourceInitialState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is IncomeSourceErrorState) {
                        return Center(child: Text(state.message));
                      }
                      if (state is IncomeSourceLoadedState) {
                        final list = state.sources ?? [];
                        return CustomGridView<IncomeSource>(
                          itemList: list,
                          selectedItems: state.selectedCategories.toSet(),
                          onItemToggle: (category) {
                            final newSelection = Set<IncomeSource>.from(state.selectedCategories);
                            final existingItem = newSelection.firstWhere(
                                  (item) => item.id == category.id,
                              orElse: () => IncomeSource(),
                            );

                            if (existingItem.id != null) {
                              newSelection.removeWhere((item) => item.id == category.id);
                            } else {
                              newSelection.add(category);
                            }

                            context.read<IncomeSourceBloc>().add(
                              UpdateSelectionEvent(newSelection.toList()),
                            );
                          },
                          itemLabel: (source) => source.name ?? '',
                          itemIcon: (source) {
                            final name = source.name ?? '';
                            if (name.contains('Salary')) {
                              return Icon(Icons.money);
                            } else if (name.contains('House')) {
                              return Icon(Icons.house);
                            } else if (name.contains('Business')) {
                              return Icon(Icons.business);
                            } else if (name.contains('Foreign')) {
                              return Icon(Icons.flight);
                            } else {
                              return Icon(Icons.attach_money);
                            }
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SafeArea(
                    minimum: const EdgeInsets.all(16.0),
                    child: BlocBuilder<IncomeSourceBloc, IncomeSourceState>(
                      builder: (context, state) {
                        final isEnabled = state is IncomeSourceLoadedState &&
                            state.selectedCategories.isNotEmpty;

                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CoreButton(
                            text: 'Continue',
                            isDisabled: !isEnabled,
                            onPressed: isEnabled ? () {
                              if (state is IncomeSourceLoadedState) {
                                debugPrint('Selected categories: ${state.selectedCategories.length}');
                              }
                              GoRouter.of(context).push(RouteName.persionalInfo);
                            } : () {},
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          title: 'Choose Services',
          isDrawer: false,
          isResizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}
