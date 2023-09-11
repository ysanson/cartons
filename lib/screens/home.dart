import 'package:cartons/models/item.dart';
import 'package:cartons/state.dart';
import 'package:cartons/widgets/add_item.dart';
import 'package:cartons/widgets/items_data_table.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../widgets/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  late AppState model;
  late Future<List<Item>> _getUnsortedItems;
  double scale = 1.0;
  bool _isAddingItem = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = Provider.of<AppState>(context);
    _getUnsortedItems = model.unsortedItems;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    Typography typography = FluentTheme.of(context).typography;
    return FutureBuilder<List<Item>>(
      future: _getUnsortedItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return ScaffoldPage.withPadding(
            header: const PageHeader(title: Text('Cartons')),
            content: const Center(child: ProgressBar()),
          );
        }
        final items = snapshot.data!;
        if (items.isNotEmpty) {
          return ScaffoldPage.scrollable(
            header: const PageHeader(title: Text('Cartons')),
            children: [
              const Text('Here is all your items that need filtering:'),
              const SizedBox(height: 22.0),
              ItemsDataTable(theme: theme, items: items),
            ],
          );
        } else {
          return ScaffoldPage.withPadding(
            header: const PageHeader(title: Text('Cartons')),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('You have no items that need filtering.  ',
                        style:
                            typography.subtitle?.apply(fontSizeFactor: scale)),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _isAddingItem = !_isAddingItem;
                        });
                      },
                      child: const Text('Add Item'),
                    ),
                  ],
                ),
                const SizedBox(height: 22.0),
                AnimatedOpacity(
                  opacity: _isAddingItem ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 50),
                  child: const AddItem(),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
