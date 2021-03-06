class UrlValidator < ActiveModel::EachValidator
  require 'uri'

  def validate_each(record, attribute, value)
    unless valid_url? value
      record.errors[attribute] << (options[:message] || "is not a valid URL")
    end
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end

class Perk < ActiveRecord::Base
  scope :active, -> {where(:is_deleted => false)}
  scope :since, lambda {|timestamp| where(:updated_at => (timestamp .. Time.now.utc))}

  before_save :normalize_blank_strings

  validates :company_name, :description, presence: true
  validates :website, :coupon, url: true, allow_blank: true

  has_attached_file :image, :styles => {
    :medium => "300x300",
    :thumb => "100x100"
  }, :path => ':rails_root/public/system/:class/:attachment/:style/:id.:extension', :url => '/system/:class/:attachment/:style/:id.:extension', :default_url => "/system/:class/:attachment/:style/missing.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def toXML(indent="")
    indent2 = indent + '    '
    xml = indent + "<company id=\"#{ERB::Util.h self.id}\">\n"
    xml += indent2 + "<name>#{ERB::Util.h self.company_name}</name>\n"
    xml += indent2 + "<category>#{ERB::Util.h self.category or "none"}</category>\n"
    xml += indent2 + "<location>#{ERB::Util.h (self.company_address.blank? ? "-" : self.company_address)}</location>\n"
    xml += indent2 + "<number>#{ERB::Util.h (self.company_phone.blank? ? "-" : self.company_phone)}</number>\n"
    xml += indent2 + "<discount>#{ERB::Util.h self.description}</discount>\n"
    if self.website
      xml += indent2 + "<website>#{ERB::Util.h self.website}</website>\n"
    end
    if self.coupon
      xml += indent2 + "<coupon>#{ERB::Util.h self.coupon}</coupon>\n"
    end
    xml += indent + "</company>\n"
  end

  def image_url
    # assume that nil image_updated_at timestamp implies no image
    "/images/#{self.id}.jpg" if self.image_updated_at
  end

  def soft_delete
    self.is_deleted = true
    self.save
  end

  # sets blank strings to nil
  def normalize_blank_strings
    attributes.each do |column, value|
      self[column] = nil if value.is_a? String and value.blank?
    end
  end
end
