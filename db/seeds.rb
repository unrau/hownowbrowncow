
# Create the default admin user account
User.create!(name:                  "Ceres",
             email:                 "browncow@unrau.me",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:                 true)
