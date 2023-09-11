import 'package:cartons/models/item.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

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

  @override
  Widget build(BuildContext context) {
    return Mica(
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
                widget.items.sort((a, b) => a.name.compareTo(b.name));
              } else {
                widget.items.sort((a, b) => b.name.compareTo(a.name));
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
    return widget.items
        .map((item) => material.DataRow(cells: [
              material.DataCell(Text(item.name)),
              material.DataCell(Text(item.description)),
              material.DataCell(Text(item.box?.name ?? 'Unsorted')),
              material.DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(FluentIcons.edit),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(FluentIcons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ]))
        .toList();
  }
}
