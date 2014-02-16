require_relative "../../../plugin_test_loader"

module AresMUSH
  module Login
    describe Create do
      before do
        @create = Create.new
      end
      
      describe :crack! do
        it "should be able to crack correct args" do
          @create.cmd = Command.new("create Bob foo")
          @create.crack!
          @create.cmd.args.name.should eq "Bob"
          @create.cmd.args.password.should eq "foo"
        end

        it "should be able to crack if args are missing" do
          @create.cmd = Command.new("create")
          @create.crack!
          @create.cmd.args.name.should be_nil
          @create.cmd.args.password.should be_nil
        end
        
        it "should be able to crack a multi-word password" do
          @create.cmd = Command.new("create Bob bob's passwd")
          @create.crack!
          @create.cmd.args.name.should eq "Bob"
          @create.cmd.args.password.should eq "bob's passwd"
        end
        
        it "should be able to crack a missing password" do
          @create.cmd = Command.new("create Bob")
          @create.crack!
          @create.cmd.args.name.should be_nil
          @create.cmd.args.password.should be_nil
        end
      end
    end
  end
end

