class Application

@@items = [Item.new("iPhone", 500), Item.new("iPad", 300)]

def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
        item_name = req.path.split("/items/").last
        item = nil
        item = @@items.find {|i| i.name.downcase == item_name.downcase} unless item_name == nil
        if item != nil
        resp.write "$#{item.price}"
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

end