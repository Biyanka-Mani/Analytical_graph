Overview

This project was developed with reference to the YouTube video Track And Graph Monthly Views | Intro To Ruby On Rails 7 Part 21 by Deanin. 
While the video served as an inspiration and guide, there are  differences. The primary goal of this project is to create a simple analytical dashboard for admin users to visualize the monthly views of posts through a graphical representation.

The data displayed on the dashboard is largely seeded and does not rely on dynamic user interactions or real-time data updates.

References and Acknowledgment

This project was inspired by the video tutorial by Deanin:
Track And Graph Monthly Views | Intro To Ruby On Rails 7 Part 21
YouTube Link: Watch Here

 Ahoy Events for sqlite
 ------------------------
 Ahoy::Event.where("json_extract(properties,'$.post_id') = ?",5)
 
 Ahoy Events for postsgresl
 ------------------------
 Ahoy::Event.where("json_extract(properties -->> 'post_id' as bigint) = ?",5)

 Ahoy Gem after GroupBy[since we have no created_at, can be grabbed by ahoy so :time]
 -----------------------------------
 daily_events.group_by_day(:time)