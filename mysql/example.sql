-- 軽度
select ST_LongFromGeoHash(geohash) from mc;

-- 緯度
select ST_latFromGeoHash(geohash) from mc;

-- ある地点から遠い順
-- 東京駅: 139.764936 35.6812362
SELECT name, address, 
st_distance(ST_GeomFromText('Point(139.764936 35.6812362)'), 
  ST_GeomFromText(CONCAT('Point(', ST_LongFromGeoHash(geohash), ' ', ST_latFromGeoHash(geohash), ')'))
    ) as distance
    FROM mc
    ORDER BY distance desc;

-- 1km 圏内
SELECT
  id, name, address, 
  ST_LENGTH(ST_GEOMFROMTEXT(
      CONCAT('LINESTRING(139.764936 35.6812362, ', ST_LongFromGeoHash(geohash),' ', ST_latFromGeoHash(geohash), ')')
  )) AS distance
FROM mc
group BY id
having distance <= 0.0089831601679492
;

