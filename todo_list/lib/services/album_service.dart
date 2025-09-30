import 'package:graphql_flutter/graphql_flutter.dart';

class AlbumGraphQLService {
  final GraphQLClient client;

  AlbumGraphQLService(this.client);

  Future<String?> fetchAlbumTitle(int id) async {
    const String query = r''' 
      query GetAlbum($id: ID!) {
        album(id: $id) {
          id
          title
        }
      }
    ''';

    final result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: {"id": id.toString()},
      ), // the id must be string
    );

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    return result.data?['album']?['title'];
  }
}
