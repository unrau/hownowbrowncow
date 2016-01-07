# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create the default admin user account
User.create!(name:                  "Ceres",
             email:                 "ceres@unrau.me",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:                 true)
