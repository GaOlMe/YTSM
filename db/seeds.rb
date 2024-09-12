# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"

puts "Destroying all transcripts..."
TranscriptLine.destroy_all
puts "Destroying all videos..."
Video.destroy_all
puts "Destroying all channels..."
Channel.destroy_all
puts "Destroying all groups..."
Group.destroy_all
puts "Destroying all users..."
User.destroy_all

puts "Creating users..."
User.create!(email:"user@example.com", password:"password")
puts "Created #{User.all.count} #{User.all.count > 1 ? "users." : "user."}"

puts "Creating groups..."
Group.create!(group_name:"Example group", user:User.first)
puts "Created #{Group.all.count} #{Group.all.count > 1 ? "groups." : "group."}"


# Read the JSON file
file = File.read('storage/video_data_UCFhXFikryT4aFcLkLw2LBLA.json')

# Parse the JSON data
data_hash = JSON.parse(file)

puts "Creating channels..."
Channel.create!(channel_name:data_hash[0][0], channel_id:data_hash[0][1], channel_logo_url:data_hash[0][2], group:Group.first, user:User.first)
puts "Created #{Channel.all.count} #{Channel.all.count > 1 ? "channels." : "channel."}"

puts "Creating videos..."
data_hash[1..-1].each do |item|
  next if item.nil?
  Video.create!(channel:Channel.first, video_id:item["video_id"], embed_link:"https://www.youtube.com/embed/#{item["video_id"]}", thumbnail_url:item["thumbnail"], upload_date:item["upload_date"], description:item["description"], views:item["views"], duration:item["duration"])
end
puts "Created #{Video.all.count} #{Video.all.count > 1 ? "videos." : "video."}"

puts "Creating transcripts..."
Video.all.each_with_index do |video, idx|
  next if data_hash[idx + 1].nil?
  data_hash[idx + 1]["transcript"].each do |line|
    TranscriptLine.create!(video:video, text:line["text"], start:line["start"], duration:line["duration"])
  end
end
puts "Created #{TranscriptLine.all.count} #{TranscriptLine.all.count > 1 ? "transcripts." : "transcript."}"
