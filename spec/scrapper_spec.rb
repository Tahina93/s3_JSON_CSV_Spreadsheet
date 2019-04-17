require_relative "../lib/scrapper"

describe "The open_page function" do
  it "return an HTML document" do
    expect(open_page("http://annuaire-des-mairies.com/95/ableiges.html").class).to eq(Nokogiri::HTML::Document)
  end
end

describe "The get_townhall_email function" do
  it "returns an email" do
    url = "http://annuaire-des-mairies.com/95/ableiges.html"
    expect(get_townhall_email(url)).to eq("mairie.ableiges95@wanadoo.fr")
  end
end

describe "The def get_townhall_urls function" do
  it "return an array of hashes" do
    url = "http://annuaire-des-mairies.com/val-d-oise.html"
    expect(get_townhall_urls(url).class).to eq(Array)
    expect(get_townhall_urls(url)[0].class).to eq(Hash)
  end
end