class ApplicationController < ActionController::Base

    include Pundit::Authorization

    before_action :authenticate_user!

    protected

    def invoice_validator_system_response(id)
        require 'uri'
        require 'net/https'
        require 'json'
    
        @to_send = { "invoice_id" => id.to_i }.to_json
    
        uri = URI.parse("https://my.api.mockaroo.com/invoices.json")
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, initheader = {"X-API-Key" => "b490bb80"})
        req.body = "#{@to_send}"
        res = https.request(req)
        result = JSON.parse(res.body).dig('status')

        if result == true
            return 'Submitted for Approval'
        else
            return 'Rejected'
        end

    end




end
