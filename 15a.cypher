MATCH (at: Aka_title),
      (cn: Company_name),
      (ct: Company_type),
      (it: Info_type),
      (k:  Keyword),
      (mc: Movie_company),
      (mi: Movie_info),
      (t:  Title)
WHERE cn.country_code = '[us]'
  AND it.info = 'release dates'
  AND mc.note =~ '.*(200.*).*'
  AND mc.note =~ '.*(worldwide).*'
  AND mi.note =~ '.*internet.*'
  AND mi.info =~ 'USA:.* 200.*'
  AND t.production_year > 2000
MATCH (at)-[ :KNOWN_AS ]->(t)
MATCH (t)<-[ :KEYWORD_OF ]-(k) 
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc) 
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct)
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it)
RETURN MIN(mi.info) AS release_date,
       MIN(t.title) AS internet_movie;
