require 'spec_helper'

describe "The Docker image built by" do

  before(:all) do

    @image = Docker::Image.build_from_dir('../')

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe 'the Dockerfile' do
    it 'should not expose any ports' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to match(nil)
    end

    it 'should have /config as volume' do
      expect(@image.json['ContainerConfig']['Volumes']).to include('/projectfiles')
    end
  end


  after(:all) do
    #@image.remove(:force => true)
  end

end
