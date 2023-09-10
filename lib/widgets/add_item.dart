import 'package:cartons/models/item.dart';
import 'package:cartons/state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final scale = 1.0;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final typography = FluentTheme.of(context).typography;
    final appState = context.watch<AppState>();
    return Mica(
      backgroundColor: theme.resources.layerOnMicaBaseAltFillColorSecondary,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New item',
                    style: typography.bodyLarge?.apply(fontSizeFactor: scale)),
                const SizedBox(height: 12.0),
                InfoLabel(
                  label: 'Name:',
                  child: TextBox(
                    controller: nameController,
                    placeholder: 'The Witcher Series',
                    expands: false,
                  ),
                ),
                const SizedBox(height: 12.0),
                InfoLabel(
                  label: 'Description:',
                  child: TextBox(
                    controller: descriptionController,
                    placeholder:
                        'The great series of books by Andrzej Sapkowski',
                    expands: false,
                    maxLines: null,
                    minLines: 2,
                  ),
                ),
                const SizedBox(height: 12.0),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Button(
                    onPressed: () async {
                      final item = Item(
                        name: nameController.text,
                        description: descriptionController.text,
                      );
                      await appState.addItem(item);
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
