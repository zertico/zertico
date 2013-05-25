require "spec_helper"

describe Zertico::Service do
  let(:controller) { Zertico::Controller.new }
  let(:object) { Object.new }

  context "#all" do
    before :each do
      controller.stub_chain(:interface_name, :pluralize, :to_sym).and_return(:users)
      controller.stub_chain(:interface_class, :all).and_return([])
    end

    it "should return a collection of objects" do
      controller.all.should == { :users => [] }
    end
  end

  context "#build" do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
      controller.stub_chain(:interface_class, :new).and_return(object)
    end

    it "should return a new object" do
      controller.build.should == { :user => object }
    end
  end

  context "#find" do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
      controller.stub_chain(:interface_class, :find).with(1).and_return(object)
    end

    it "should return the specified object" do
      controller.find(1).should == { :user => object }
    end
  end

  context "#generate" do
    before :each do
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
      controller.stub_chain(:interface_class, :create).with({}).and_return(object)
    end

    it "should return the created object" do
      controller.generate({}).should == { :user => object }
    end
  end

  context "#modify" do
    before :each do
      controller.stub(:find).with(1).and_return(object)
      object.stub(:update_attributes).with({}).and_return(true)
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
    end

    it "should return the updated object" do
      controller.modify(1, {}).should == { :user => object }
    end
  end

  context "#delete" do
    before :each do
      controller.stub(:find).with(1).and_return(object)
      object.stub(:destroy).and_return(true)
      controller.stub_chain(:interface_name, :to_sym).and_return(:user)
    end

    it "should return the destroyed object" do
      controller.delete(1).should == { :user => object }
    end
  end
end