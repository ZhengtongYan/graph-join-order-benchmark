MATCH (ci:     Cast_info),
      (it1:    Info_type),
      (it2:    Info_type),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (n:      Name),
      (t:      Title)
WHERE ci.note IN ['(writer)',
                  '(head writer)',
                  '(written by)',
                  '(story)',
                  '(story editor)']
  AND it1.info = 'genres'
  AND it2.info = 'votes'
  AND mi.info IN ['Horror',
                  'Action',
                  'Sci-Fi',
                  'Thriller',
                  'Crime',
                  'War']
  AND n.gender = 'm'
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(:Aka_name)-[ :NAME_OF ]->(n)
RETURN MIN(mi.info) AS movie_budget,
       MIN(mi_idx.info) AS movie_votes,
       MIN(t.title) AS movie_title;
