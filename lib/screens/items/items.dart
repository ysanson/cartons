import 'package:cartons/models/box.dart';
import 'package:cartons/models/item.dart';
import 'package:cartons/state.dart';
import 'package:cartons/utils/wait_concurrently.dart';
import 'package:cartons/widgets/add_item.dart';
import 'package:cartons/widgets/items_data_table.dart';
import 'package:cartons/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> with PageMixin {
  late AppState model;
  late Future<List<Item>> _getAllItems;
  late Future<List<Box>> _getBoxes;
  double scale = 1.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = Provider.of<AppState>(context);
    _getAllItems = model.items;
    _getBoxes = model.boxes;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return FutureBuilder<(List<Item>, List<Box>)>(
        future: waitConcurrently(_getAllItems, _getBoxes),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ScaffoldPage.withPadding(
              header: const PageHeader(title: Text('Items')),
              content: const Center(child: ProgressBar()),
            );
          }
          final (items, boxes) = snapshot.data!;
          return ScaffoldPage.scrollable(
            header: const PageHeader(title: Text('Items')),
            children: [
              const AddItem(),
              const Spacer(),
              if (items.isNotEmpty)
                ItemsDataTable(theme: theme, items: items, boxes: boxes)
            ],
          );
        });
  }
}
