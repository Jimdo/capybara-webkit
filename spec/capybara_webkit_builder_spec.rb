require 'spec_helper'
require 'capybara_webkit_builder'

describe CapybaraWebkitBuilder do
  let(:builder) { CapybaraWebkitBuilder }

  it "will use the env variable for #make_bin" do
    with_env_vars("MAKE" => "fake_make") do
      builder.make_bin.should == "fake_make"
    end
  end

  it "will use the env variable for #qmake_bin" do
    with_env_vars("QMAKE" => "fake_qmake") do
      builder.qmake_bin.should == "fake_qmake"
    end
  end

  it "will use the env variable for #os_spec" do
    with_env_vars("SPEC" => "fake_os_spec") do
      builder.spec.should == "fake_os_spec"
    end
  end

  it "defaults the #make_bin" do
    builder.make_bin.should == 'make'
  end

  it "defaults the #qmake_bin" do
    builder.qmake_bin.should == 'qmake'
  end

  it "defaults #spec to the #os_specs" do
    builder.spec.should == builder.os_spec
  end

  describe "#link_existing_binary_for_platform" do

    describe "when no precompiled binary is available" do
      it "should return false" do
        builder.link_existing_binary_for_platform.should == false
      end
    end

    describe "when precompiled binary is available" do
      around :each do |example|
        begin
          save_path_env = ENV['PATH']
          ENV['PATH'] = "#{Dir.tmpdir}:#{ENV['PATH']}"

          webkit_binary = "#{Dir.tmpdir}/webkit_server"
          File.new(webkit_binary, File::CREAT|File::TRUNC|File::RDWR, 0700).close
          
          example.run
        ensure
          ENV['PATH'] = save_path_env
          FileUtils.rm webkit_binary
        end
      end

      it "should return true" do
        builder.link_existing_binary_for_platform.should == true
        
      end

    end

    # it "should not find a precomiled binary" do
    # end
  end
end

