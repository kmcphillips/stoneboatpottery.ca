namespace :posts do

  desc "Generate system posts based on recent activity"
  task :generate_update => :environment do

    raise "incomplete"

    # only do something if there are posts that need to be summarized
    if posts.any?
      # create the body
      body = "<ul>\n"

      # iterate over posts and append them to the body text
      posts.each do |post|
        body += "<li><a href=\"#{polymorphic_path(post)}\"></a></li>\n"
      end

      body += "</ul>"

      # create system post
      SystemPost.create! :title => "Updates for #{Time.now.to_s(:simple_short)}", :body => body

    end
  end
end