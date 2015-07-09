require 'selenium-webdriver'
require 'rspec'
require 'net/http'
require 'rubygems'
#require 'nokogiri'

describe "three website" do
	attr_reader :selenium_driver
	attr_reader :three_uri

	before :each do
		@three_uri = URI.parse 'http://www.three.co.uk'
	end

	after :each do
	end

	it "should have http on home page" do
		expect((@three_uri.instance_of? URI::HTTP)).to be true
	end

	it "should transfer to https on login page" do
		expect((@three_uri.instance_of? URI::HTTPS)).to eq(true)
		http = Net::HTTP::new(@three_uri.host, @three_uri.port)
		request = Net::HTTP::Get.new('https://www.three.co.uk/My3Account/Login')
		response = http.request(request)
		expect(response.code).to eq('301')
		expect((@request.instance_of? URI::HTTPS)).to eq(true)
	end

	it "should confirm TLS 1.0" do
	end

	it "should not have missing security headers" do
		http = Net::HTTP.new(@three_uri.host, @three_uri.port)
		request = Net::HTTP::Get.new(@three_uri.request_uri)
		response = http.request(request)

		expect(response["x-frame-options"]).to be nil
		expect(response["strict-transport-security"]).to be nil
	end

	it "should not redirect with invalid data" do
		driver = Selenium::Webdriver.for :firefox
		driver.navigate.to 'https://www.three.co.uk/My3Account/Login'
		driver.find_element(:name, 'username').send_keys '07402843429'
		driver.find_element(:name, "j_password").send_keys 'my3test'
	end

	it "should not complete javascript injection" do
		http = Net::HTTP.new(@three_uri.host, @three_uri.port)
		request = Net::HTTP::Get.new(@three_uri.request_uri)
		response = http.request(request)

		#login_page = Nokogiri::HTML(open(''))
	end
end