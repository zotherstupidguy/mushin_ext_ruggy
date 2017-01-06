require_relative 'spec_helper'
require 'rugged'

describe "Ruggy" do
  before do
    #`rm -rf  DATA` #NOTE flush all previous test data
    @env 		= Hash.new
    @slug 		= "pengwynn/pingwynn"
    @clone_url 		= "https://github.com/#{@slug}.git"
    @local_repo_path 	= ("./DATA/#{@slug}")
  end
  after do
  end

  it "take clones from a repo clone_url to a local_repo_path" do

    @params = {:slug => @slug}

    @env[:host] = Hash.new
    @env[:host][@slug.to_sym] = Hash.new 
    @env[:host][@slug.to_sym][:clone_url] = @clone_url

    p @env

    #env[:slug][:repo]

    File.directory?(@local_repo_path).must_equal true 
  end

  #TODO to be refactored into Mushin::Ruggy ext
  it "recognizes the langauge of the code" do
    #gem install github-linguist
    #require 'linguist'
    #repo = Rugged::Repository.new('.')
    #project = Linguist::Repository.new(repo, repo.head.target_id)
    #project.language       #=> "Ruby"
    #project.languages      #=> { "Ruby" => 119387 }
  end
end
