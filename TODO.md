# TODO List: Fix receive id agar tidak mengembalikan index

## Plan
1. **home.dart**: Change `'index': index` to `'user_id': item['id']` in navigation arguments
2. **route_handler.dart**: Change to accept `user_id` parameter instead of `index`
3. **chat_page.dart**: Change `index` parameter to `userId` and update its usage

## Status
- [x] Edit home.dart - pass user_id (from item['id']) instead of index
- [x] Edit route_handler.dart - accept user_id parameter
- [x] Edit chat_page.dart - use userId instead of index

