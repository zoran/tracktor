require "test_helper"

describe "Rakefile" do
  describe "help" do
    it "lists all tasks" do
      out, err = capture_subprocess_io do
        Rake::Task[:help].execute
      end
      assert_match /rake help/, out
    end
  end
end
