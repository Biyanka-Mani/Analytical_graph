class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user



  def view_by_day
    daily_events = Ahoy::Event.where("json_extract(properties,'$.post_id') = ?",id)
    daily_events.group_by_day(:time,range: 1.month.ago..Time.now).count
  end
  def self.total_view_by_day
    daily_events = Ahoy::Event.where(name:"Viewed Posts")
    daily_events.group_by_day(:time,range: 1.month.ago..Time.now).count
  end
end
