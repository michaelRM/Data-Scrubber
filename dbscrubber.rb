require 'faker'



namespace :db do

  namespace :data do

   desc "Iterate through DB and anonymize sensitive info(User first/last name, email password. Document name and description)"

    task :fake_user_data => :environment do

      STDERR.puts 'Anonymize data'\

      STDERR.print 'y/n: '

      exit if STDIN.readline.chomp != 'y'



      User.all.each do |user|

        first    = Faker::Name.first_name

        last     = Faker::Name.last_name

        email    = Faker::Internet.email

        password = 'testing'

        attrs    = { first_name:       first

                     last_name:        last

                     crypted_password: password

                     email:            email }

        user.update_attributes attrs



     Document.all.each do |document|

       name         =  Faker::Lorem.words 1..3

       descriptions =  Faker::Lorem.words 5..10

       attrs        = { name:        name

                        description: description }

       document.update_attributes attrs

    end

  end

end

