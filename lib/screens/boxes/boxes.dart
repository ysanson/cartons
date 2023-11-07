import 'package:cartons/models/box.dart';
import 'package:cartons/state.dart';
import 'package:cartons/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class BoxesPage extends StatefulWidget {
  const BoxesPage({Key? key}) : super(key: key);

  @override
  State<BoxesPage> createState() => _BoxesPageState();
}

class _BoxesPageState extends State<BoxesPage> with PageMixin {
  late AppState model;
  late Future<List<Box>> _getBoxes;
  double scale = 1.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = Provider.of<AppState>(context);
    _getBoxes = model.boxes;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Boxes')),
      content: const Center(child: Text('Boxes')),
    );
  }
}
