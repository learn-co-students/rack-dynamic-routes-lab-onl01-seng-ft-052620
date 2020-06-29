require 'pry'

class Application
    @@items = []
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item = req.path.gsub("/","").split(/items/)[1]
            if self.class.items.map{|item| item.name}.include?(item)
                resp.write "Price: #{self.class.find_by_name(item).price}"
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404 
        end

        resp.finish
    end


    def self.items
        @@items
    end

    def self.find_by_name(name)
        self.items.find{|item| item.name = name}
    end
end