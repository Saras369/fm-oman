// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// class KPagingController<PageKeyType, ItemType>
//     extends PagingController<PageKeyType, ItemType> {
//   KPagingController({
//     required PageKeyType firstPageKey,
//     int? invisibleItemsThreshold,
//   }) : super(
//             firstPageKey: firstPageKey,
//             invisibleItemsThreshold: invisibleItemsThreshold);
//
//   bool _loading = false;
//
//   bool get loading => _loading;
//
//   bool bg = false;
//
//   @override
//   void refresh({bool background = false}) {
//     if (background) {
//       bg = true;
//       _loading = true;
//       notifyPageRequestListeners(firstPageKey);
//     } else {
//       bg = false;
//       _loading = true;
//       super.refresh();
//     }
//   }
//
//   @override
//   void appendPage(List<ItemType> newItems, PageKeyType? nextPageKey) {
//     if (bg) {
//       final previousItems =
//           _loading ? <ItemType>[] : value.itemList ?? <ItemType>[];
//       final itemList = previousItems + newItems;
//
//       value = PagingState<PageKeyType, ItemType>(
//         itemList: itemList,
//         error: null,
//         nextPageKey: nextPageKey,
//       );
//     } else {
//       final previousItems = value.itemList ?? [];
//       final itemList = previousItems + newItems;
//       value = PagingState<PageKeyType, ItemType>(
//         itemList: itemList,
//         error: null,
//         nextPageKey: nextPageKey,
//       );
//     }
//
//     _loading = false;
//   }
// }
