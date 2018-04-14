class GoogleService
  include HTTParty 

  def self.valid_token?(id_token)
    status = false
    begin
      response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=" + id_token, :headers =>{'Content-Type' => 'application/json'})  
      if response.code == 200 && response['hd'] == 'unal.edu.co'
        status = true
      end
    ensure
      return status
    end
  end
  
  def self.fetch_data(id_token)    
    response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=" + id_token, :headers =>{'Content-Type' => 'application/json'})
        
    data = Hash.new
    data['name'] = response['given_name']
    data['last_name'] = response['family_name']
    data['email'] = response['email']
    data['photo'] = response['picture']
    return data
  end 
end