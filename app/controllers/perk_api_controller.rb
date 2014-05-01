# All responses are XML
class PerkApiController < ApplicationController
  before_action :validate_datetime, only: :list_since

  # Returns a list of all perks that haven't been deleted.
  def list_all
    perk_list_xml = perk_list_to_xml(Perk.active)
    respond_to do |format|
      format.any do
        headers["Content-Type"] = "application/xml; charset=utf-8"
        render :xml => perk_list_xml
      end
    end
  end

  # Returns a list of perks that have been updated
  # since the given timestamp, including deleted perks.
  # 
  # If no timestamp is given, defaults to list_all behavior.
  def list_since
    if params[:datetime].nil?
      return list_all()
    else
      timestamp = Time.parse params[:datetime] # TODO sanitize for security # TODO fix timezones
      perk_list_xml = perk_list_to_xml(Perk.since(timestamp))
      respond_to do |format|
        format.any do
          headers["Content-Type"] = "application/xml; charset=utf-8"
          render :xml => perk_list_xml
        end
      end
    end
  end

  private

  def perk_list_to_xml perk_list
    '<?xml version="1.0" encoding="utf-8"?>' + "\n" +
      "<companyList>\n" +
      (perk_list.map do |perk|
         perk.toXML('     ')
       end.join '') +
      "</companyList>"
  end

  def validate_datetime
    if params[:datetime]
      begin
        Time.parse params[:datetime]
      rescue ArgumentError
        render :nothing => true, :status => 400
      end
    end
  end
end
