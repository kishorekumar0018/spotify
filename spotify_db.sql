select * from spotify;

select count(*) from spotify;

select  min(duration_min)from spotify;

select * from spotify
where duration_min = 0;

delete from spotify
where duration_min = 0;

select distinct most_playedon from spotify;

-----------------------------------
-- Data Analysis - Easy Category
-----------------------------------

-- Q.1 Retrieve the names of all tracks that have more than 1 billion streams.
select * from spotify
where stream > 1000000000;

-- Q.2 List all albums along with their respective artists.
select album,artist from spotify;

-- Q.3 Get the total number of comments for tracks where licensed = TRUE.

select sum(comments) as total_comments from spotify
where licensed = 'True';

-- Q.4 Find all tracks that belongs to the album type single.

select track from spotify
where album_type = 'single';

-- Q.5 Count the total number of tracks by each artist.
select artist,count(*) as total_track from spotify
group by artist
order by  2 asc;

-----------------------
Medium Level 
-----------------------
-- Q.6 Calculate the average danceability of tracks in each album.
select album,avg(danceability) as avg_danceability
from spotify
group by album
order by 2 desc;

-- Q.7 Find the top 5 tracks with the highest energy values.
select track,energy from
(select track,energy
from spotify
order by 2 desc)
where rownum <= 5;

-- Q.8 List all tracks along with their views and likes where offical_video = true.
select track,sum(views) as total_view,sum(likes) as total_likes from spotify
where official_video = 'True'
group by track;

-- Q.9 For each album,calculate the total views of all associated tracks.
select album,track,sum(views)
from spotify
group by album,track
order by 3 desc;

-- Q.10 Retrieve the tracks names that have been streamed on spotify more than youtube.
select track
from spotify
group by track
having
    sum(case when most_playedon = 'Spotify' then stream else 0 end)>
    sum(case when most_playedon = 'Youtube' then stream else 0 end);

----------------------
Advanced Problems
----------------------
-- Q.11 Find the top 3 most viwed tracks for each artist using window functions

with ranking_artist
as
(select artist,track,sum(views) as total_views,
dense_rank() over(partition by artist order by sum(views) desc) as rank
from spotify
group by artist,track
order by artist,sum(views) desc
)
select * from ranking_artist
where rank <=3; 

--Q.12 Write a query to find tracks where the liveness score is above the average.
select track,liveness from
(select track, liveness from spotify
where liveness > 0.1936720862470862470862470862470862470862)
spotify;

select avg(liveness) from spotify;

--Q.13 Use a with clause to calculate the difference between the highest and lowest energy valuse for tracks in each album.
with cte
as
(select album,max(energy)as highest_energy,min(energy) as lowest_energy
from spotify
group by album
)
select album,highest_energy - lowest_energy as energy_diff
from cte;

--Q14. Track where the energy-to-liveness ratio is greater than 1.2.
select liveness from spotify;

select track,(energy/liveness) as energy_liveness_ratio
from spotify
where (energy/liveness) >1.2;

--Q.15 Calculate the cumulative sum of likes for tracks ordered by the number of views,using window function.
select track,views,likes,sum(likes) over(order by views) as cumulative_likes
from spotify; 





