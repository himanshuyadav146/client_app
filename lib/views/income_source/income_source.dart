import 'package:client_app/core/index.dart';
import 'package:client_app/core/utils/enums.dart';
import 'package:client_app/core/widgets/custom_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/income_source/income_source_bloc.dart';
import '../../blocs/income_source/income_source_event.dart';
import '../../blocs/income_source/income_source_state.dart';
import '../../main.dart';

class IncomeSourceView extends StatefulWidget {
  IncomeSourceView({super.key});

  @override
  State<IncomeSourceView> createState() => _IncomeSourceViewState();
}

class _IncomeSourceViewState extends State<IncomeSourceView> {
  // List of categories for the grid
  final List<Category> _categoryList = [
    Category.salary,
    Category.houseProperty,
    Category.rentalIncome,
    Category.abroadIncome,
    Category.businessIncome,
    Category.otherIncome,
  ];

  // State variable to track the selected category
  Set<Category> _selectedCategory = {};

  late final IncomeSourceBloc _incomeSourceBloc;

  @override
  void initState() {
    super.initState();
    _incomeSourceBloc = getIt<IncomeSourceBloc>();
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
      child: CoreScaffold(
        appBarBackgroundColor: Theme.of(context).primaryColor,
        appBarForegroundColor: Colors.white,
        showBackButton: true,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<IncomeSourceBloc, IncomeSourceState>(
                  builder: (context, state) {
                    return CustomGridView<Category>(
                      itemList: _categoryList,
                      selectedItems: _selectedCategory,
                      onItemToggle: (category) {
                        setState(() {
                          if (_selectedCategory.contains(category)) {
                            _selectedCategory.remove(category); // Deselect
                          } else {
                            _selectedCategory.add(category); // Select
                          }
                        });
                      },
                      itemLabel: (category) => category.name,
                      itemIcon: (category) => Icon(category.icon),
                    );
                  },
                ),
              ),
              SafeArea(
                minimum: const EdgeInsets.all(16.0), // Keeps your padding
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CoreButton(
                    text: 'Continue',
                    onPressed: () {
                      GoRouter.of(context).go(RouteName.persionalInfo);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        title: 'Choose Services',
        isDrawer: false,
        isResizeToAvoidBottomInset: false,
      ),
    );
  }
}
