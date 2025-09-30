import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final HttpLink httpLink = HttpLink(
    "https://graphqlzero.almansi.me/api",
  ); // this is endpoint URL of server
  /*
GraphQLClient: Là "khách hàng" (client) dùng để gửi request đến server GraphQL và nhận kết quả.
Trong GraphQLClient, bạn cần cấu hình:
  link: cách client kết nối tới server (ở đây là HttpLink).
  cache: cách client lưu trữ dữ liệu đã query để tái sử dụng.
 */
  static ValueNotifier<GraphQLClient> initClient() {
    return ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );
  }
}
