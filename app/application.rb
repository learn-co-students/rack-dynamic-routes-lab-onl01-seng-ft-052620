class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
 
    if req.path.match(/items/)
      item_requested = req.path.split("/items/").last 
      if item = @@items.detect{|i| i.name == item_requested}
      resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
 
    resp.finish
  end
  
end