class Link < ActiveRecord::Base

  validates_presence_of :url
  validates_uniqueness_of :url
  validate :url_begins_with_protocol

  date_scopes

  protected

  def url_begins_with_protocol
    errors.add(:url, "must begin with 'http://' or 'https://'") unless url =~ /http(s)?:\/\/.+/
  end
end
