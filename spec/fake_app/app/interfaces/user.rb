class User
  def self.all
    [new, new]
  end

  def self.find(id)
    new
  end

  def self.create(params)
    new
  end

  def update_attributes(params)
    true
  end

  def destroy
    true
  end
end