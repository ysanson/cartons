import 'package:cartons/models/item.dart';
import 'package:cartons/state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';

class ItemsDataTable extends StatefulWidget {
  const ItemsDataTable({
    super.key,
    required this.theme,
    required this.items,
  });

  final FluentThemeData theme;
  final List<Item> items;

  @override
  State<ItemsDataTable> createState() => _ItemsDataTableState();
}

class _ItemsDataTableState extends State<ItemsDataTable> {
  int _currentSortColumn = 0;
  bool _isSortAsc = true;
  int _currentEditId = -1;
  late List<Item> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items.toList();
  }

  @override
  Widget build(BuildContext context) {
    return material.Material(
      color: Colors.transparent,
      type: material.MaterialType.transparency,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
      child: Mica(
        backgroundColor:
            widget.theme.resources.layerOnMicaBaseAltFillColorSecondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: SizedBox(
              width: double.infinity,
              child: material.DataTable(
                  columns: _createColumns(),
                  rows: _createRows(),
                  sortColumnIndex: _currentSortColumn,
                  sortAscending: _isSortAsc),
            ),
          ),
        ),
      ),
    );
  }

  List<material.DataColumn> _createColumns() {
    return [
      material.DataColumn(
          label: const Text('Item'),
          onSort: (columnIndex, _) {
            setState(() {
              _currentSortColumn = columnIndex;
              if (_isSortAsc) {
                _items.sort((a, b) => a.name.compareTo(b.name));
              } else {
                _items.sort((a, b) => b.name.compareTo(a.name));
              }
              _isSortAsc = !_isSortAsc;
            });
          }),
      const material.DataColumn(label: Text('Description')),
      const material.DataColumn(label: Text('Box')),
      const material.DataColumn(label: Text('')),
    ];
  }

  List<material.DataRow> _createRows() {
    return _items
        .map((item) => material.DataRow(cells: [
              material.DataCell(Text(item.name)),
              material.DataCell(Text(item.description)),
              material.DataCell(Text(item.box?.name ?? 'Unsorted')),
              material.DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(FluentIcons.edit),
                      onPressed: () {
                        setState(() {
                          _currentEditId = item.id ?? -1;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(FluentIcons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ContentDialog(
                                title: const Text('Confirm deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  FilledButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      Provider.of<AppState>(context,
                                              listen: false)
                                          .deleteItem(item)
                                          .then((_) => Navigator.pop(context));
                                    },
                                  ),
                                  Button(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ]))
        .toList();
  }
}
