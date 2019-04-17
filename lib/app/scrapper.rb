require 'open-uri'

class Scrapper
  def initialize(url)
    @url = url
    @session = GoogleDrive::Session.from_config("config.json")
  end

  def open_page(url)
    Nokogiri::HTML(open(url))
  end

  def get_townhall_email(url)
    page = open_page(url)
    email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    email
  end

  def get_townhall_urls
    page = open_page(@url)
    towns = page.xpath('//td/*/a[@class="lientxt"]')
    @towns_emails = []
    towns.each do  |town|
      name = town.text
      href = town["href"]
      url="http://annuaire-des-mairies.com" + href.slice(1, href.length - 1)
      email = get_townhall_email(url)
      @towns_emails << { name => email}
    end

    puts @towns_emails
  end

  def save_as_JSON
    File.open("db/emails.json","w") do |f|
    f.write(@towns_emails.to_json) 
    end
  end

  def save_as_spread_sheet
    ws = @session.spreadsheet_by_key("1aCfQxBDUoFnfgzZnCmFhP9Wfbb8uAg92OC1jKe8qiTU").worksheets[0]
    ws[1, 1] = "ville"
    ws[1, 2] = "email"

    @towns_emails.each_with_index do |h,i|
      ws[i+2, 1] = h.keys[0]
      ws[i+2, 2] = h.values[0]
    end

    ws.save
  end


  def save_as_csv
    CSV.open("db/emails.csv", "w") do |csv|
      @towns_emails.each do |hash|
        
          csv << hash.to_a.flatten
      end
    end

  end
  
  def perform
    get_townhall_urls
    #save_as_JSON
    #save_as_spread_sheet
    save_as_csv
  end

end
