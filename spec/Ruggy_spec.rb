require_relative 'spec_helper'
require 'rugged'

describe "Gitlapse" do
  before do
    #`rm -rf  DATA` #NOTE flush all previous test data
    @env 		= Hash.new
    @slug 		= "pengwynn/pingwynn"
    @clone_url 		= "https://github.com/#{@slug}.git"
    @local_repo_path 	= ("./DATA/#{@slug}")
  end
  after do
  end

  #TODO to be refactored into Mushin::Ruggy ext
  it "take clones from a repo clone_url to a local_repo_path" do
    Rugged::Repository.clone_at(@clone_url, @local_repo_path, {
      transfer_progress: lambda { |total_objects, indexed_objects, received_objects, local_objects, total_deltas, indexed_deltas, received_bytes|
	print("\r total_objects: #{total_objects}, indexed_objects: #{indexed_objects}, received_objects: #{received_objects}, local_objects: #{local_objects}, total_deltas: #{total_deltas}, indexed_deltas: #{indexed_deltas}, received_bytes: #{received_bytes}")
      }
    })
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
