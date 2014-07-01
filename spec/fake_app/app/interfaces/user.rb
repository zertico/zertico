class User < ActiveRecord::Base
  attr_reader :updated, :destroyed

  def initialize
    @updated = false
    @destroyed = false
    super
  end

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
    @updated = true
    true
  end

  def destroy
    @destroyed = true
    true
  end
end