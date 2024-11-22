# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Category.destroy_all
Post.destroy_all
  def seed_users
      users = [
        { email: 'john@example.com', password: 'password123',is_admin: true},
        { email: 'sarah@example.com', password: 'password123' },
        { email: 'mike@example.com', password: 'password123' }
      ]

      users = users.map do |user_attrs|
        User.find_or_create_by!(email: user_attrs[:email]) do |u|
          u.password = user_attrs[:password]
        end
      end
  end
  def seed_categories
    categories = Category.create!([
    { name: 'Technology' },
    { name: 'Space Exploration' },
    { name: 'Travel' },
    { name: 'Humor' },
    { name: 'Science' }
    ])

    categories.each do |category_name|
      Category.find_or_create_by!(name: category_name)
    end
  end
  def seed_posts
    categories = Category.all
    users = User.all
  
    posts = Post.create!([
      {
        title: 'Mars Mission Preparation',
        content: 'Detailed planning for the first human mission to Mars, including spacecraft design, life support systems, and psychological preparation for long-duration space travel.',
        category: categories.find { |c| c.name == 'Space Exploration' },
        user: users.first
      },
      {
        title: 'Funny Space Jokes Collection',
        content: 'A compilation of the most hilarious jokes about space travel, astronauts, and extraterrestrial life. Warning: May cause uncontrollable laughter in zero gravity!',
        category: categories.find { |c| c.name == 'Humor' },
        user: users.second
      },
      {
        title: 'Advanced Rocket Propulsion Technologies',
        content: 'An in-depth look at cutting-edge propulsion systems that could revolutionize interplanetary travel, including ion engines, nuclear thermal propulsion, and theoretical breakthrough concepts.',
        category: categories.find { |c| c.name == 'Technology' },
        user: users.third
      },
      {
        title: 'Top 10 Destinations for Space Tourists',
        content: 'As space tourism becomes a reality, explore the most exciting potential destinations for adventurous travelers looking to go beyond Earth\'s boundaries.',
        category: categories.find { |c| c.name == 'Technology' },
        user: users.first
      },
      {
        title: 'The Future of Martian Colonization',
        content: 'Comprehensive analysis of challenges and opportunities for establishing permanent human settlements on Mars, including habitat design, resource utilization, and long-term survival strategies.',
        category: categories.find { |c| c.name == 'Technology' },
        user: users.second
      }
    ])
  end
  def seed_ahoy
    Ahoy.geocode = false
    request = OpenStruct.new(
    params: {},
    referer: 'http://example.com',
    remote_ip: '15.0.0.0',
    user_agent: 'Internet Explorer, lol can you imagine?',
    original_url: 'rails'
  )
    visit_properties = Ahoy::VisitProperties.new(request, api: nil)
    properties = visit_properties.generate.select { |_, v| v }
    example_visit = Ahoy::Visit.create!(properties.merge(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid
    ))
  
    2.months.ago.to_date.upto(Date.today) do |date|
      Post.all.each do |post|
        rand(1..5).times do |_|
          Ahoy::Event.create!(name: 'Viewed Post',
                              visit: example_visit,
                              properties:  { 'post_id' => post.id },
                              time: date.to_time + rand(0..23).hours + rand(0..59).minutes)
        end
      end
    end
  end


seed_users
seed_categories
seed_posts
seed_ahoy
