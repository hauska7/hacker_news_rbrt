module QueriesAR
  def self.build
    Queries
      .build
      .set_query_post_where_id(query: QueryARPostWhereID.build)
      .set_query_post_with_comments_where_id(query: QueryARPostWithCommentsWhereID.build)
  end
end
