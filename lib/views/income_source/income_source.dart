import 'package:client_app/core/index.dart';
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
  late final IncomeSourceBloc _incomeSourceBloc;

  final List<String> items = [
    'salary',
    'house property',
    'rent',
    'foreign income',
    'business',
    'other income'
  ];


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
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<IncomeSourceBloc, IncomeSourceState>(
                builder: (context, state) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final isSelected = (index < state.selectedItems.length) ? state.selectedItems[index] : false;


                      return GestureDetector(
                        onTap: () => context.read<IncomeSourceBloc>().add(ToggleItem(index)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blueAccent : Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: isSelected
                                ? [BoxShadow(color: Colors.blue.withBlue(5), blurRadius: 10)]
                                : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.attach_money, size: 40, color: Colors.white),
                              const SizedBox(height: 10),
                              Text(
                                items[index],
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity, // Button stretches full width
                height: 50,
                child: CoreButton(
                    text: 'Continue',
                    onPressed:() {
                      GoRouter.of(context).go(RouteName.persionalInfo);
                    }),
              ),
            ),
          ],
        ),
        title: 'Choose Services',
        isDrawer: false,
        isResizeToAvoidBottomInset: false,
      ),
    );
  }
}
