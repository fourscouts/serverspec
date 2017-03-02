require 'spec_helper'

describe "Container" do

  before(:all) do
    @image = Docker::Image.build_from_dir($project_root)

    set :docker_image, @image.id
  end

  describe 'when running' do
    before(:all) do
      @container = Docker::Container.create(
          'Image' => @image.id,
          'Cmd' => ['bash']
      )
      @container.start()

      set :docker_container, @container.id
    end


    it "runs alpine version 3.5" do
      expect(file('/etc/os-release')).to be_a_file
      os_version = command('cat /etc/os-release')
      expect(os_version.stdout).to include('PRETTY_NAME="Alpine Linux v3.5"')
    end

    it "has ruby version 2.3.3 installed" do
      ruby_version = command('ruby -v').stdout
      expect(ruby_version).to include('2.3.3')
    end

    requiredPackages = %w(
        build-base
        bash
        curl
        ruby
        ruby-dev
    )

    requiredPackages.each { |apkPackage|
      describe package(apkPackage) do
        it { is_expected.to be_installed }
      end
    }

    it "runs kubectl version 1.5.3" do
      os_version = command('kubectl version')
      expect(os_version.stdout).to include('1.5.3')
    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
    end
  end
end
