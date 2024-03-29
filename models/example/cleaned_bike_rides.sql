{{
    config(
        materialized='incremental',
        unique_key= ['month','start_peak_travel','same_station_flag','start_station_id','end_station_id'] 
    )
}}

SELECT
    SUM(duration_minutes) as total_minutes
    , COUNT(rental_id) as total_bike_hires
    , ROUND(SUM(duration_minutes) / COUNT(rental_id), 2) AS average_duration
    , EXTRACT(month from start_date) as month
    , CASE
        WHEN EXTRACT(HOUR from TIMESTAMP(start_date)) >= 6 AND EXTRACT(HOUR from TIMESTAMP(start_date)) <= 10 THEN 'Morning Peak'
        WHEN EXTRACT(HOUR from TIMESTAMP(start_date)) >= 16 AND EXTRACT(HOUR from TIMESTAMP(start_date)) <= 19 THEN 'Evening Peak'
        ELSE 'Off-Peak'
      END AS start_peak_travel
    , IF(start_station_id = end_station_id, True, False) as same_station_flag
    , start_station_id
    , start_station_name
    , end_station_id
    , end_station_name
FROM {{ ref('raw_bike_hires') }}

{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  -- (uses >= to include records arriving later on the same day as the last run of this model)
 WHERE EXTRACT(month from start_date)  >= (select max(month) from {{ this }})
{% endif %}    

GROUP BY 4,5,6,7,8,9,10
ORDER BY total_minutes DESC
