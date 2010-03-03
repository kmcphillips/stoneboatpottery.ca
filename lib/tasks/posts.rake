namespace :posts do

  desc "Generate system posts based on recent activity"
  task :generate_update => :environment do

    raise "incomplete"

    # get the last run date
    start_date = SystemPost.find(:first, :order => "created_at DESC").try(:created_at).try(:beginning_of_day) || 1.month.ago
    end_date = Time.now.beginning_of_day

    # don't process if this is the same date
    unless start_date == end_date

      # find Posts for the date range


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
end
