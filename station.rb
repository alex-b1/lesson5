require_relative './instance_counter.rb'

class Station
  include InstanceCounter

  @@instances = {}
  attr_accessor :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    @@instances[name] = self

    register_instance
  end


  def arrival_train(train)
    @trains << train
  end

  def depart_train(train)
    @trains.filter! {|i| i.number != train.number}
    train.go_ahead

    while train.accelerate < 80
      train.accelerate
    end
  end

  def get_trains_by_type
   list = {
     cargo: (@trains.filter {|i| i.type == :cargo}).count ,
     passenger: (@trains.filter {|i| i.type == :passenger}).count,
    }
  end

  def self.all
    @@instances
  end
end