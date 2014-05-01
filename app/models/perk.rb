class Perk < ActiveRecord::Base
  def toXML(indent="")
    indent2 = indent + '    '
    xml = indent + "<company id=\"#{self.id}\">\n"
    if self.company_name
      xml += indent2 + "<name>#{self.company_name}</name>\n"
    end
    if self.company_address
      xml += indent2 + "<location>#{self.company_address}</location>\n"
    end
    if self.company_phone
      xml += indent2 + "<number>#{self.company_phone}</number>\n"
    end
    if self.description
      xml += indent2 + "<discount>#{self.description}</discount>\n"
    end
    if self.website
      xml += indent2 + "<website>#{self.website}</website>\n"
    end
    xml += indent2 + "<category>none</category>\n" #TODO
    if self.coupon
      xml += indent2 + "<coupon>#{self.coupon}</coupon>\n"
    end
    xml += indent + "</company>\n"
  end
end
