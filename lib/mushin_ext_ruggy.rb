require 'mushin'
require_relative 'Ruggy/version'


module Ruggy
  class Ext 
    using Mushin::Ext 

    def initialize app=nil, opts={}, params={}
      @app 		= app
      @opts 	= opts
      @params 	= params 
    end

    def check_params *keys
      return (keys.all? {|key| (@params.key?(key) && !@params[key].nil?)})
    end

    def call env 
      env ||= Hash.new 

      case @opts[:cqrs]
      when :cqrs_query 
	#inbound code
	@app.call(env)
	#outbound code
      when :cqrs_command
	#inbound code
	env[:repo] =  @repo 

	#env[:repo][:master][:commit_sha][:blob_sha]
	#env[:repo][:master][:filepath]
	env[:repo][:blob][:branch][:filepath]
	env[:repo][:tree][:branch][:dirpath]

	@app.call(env)
	#outbound code
      else
	raise "Ruggy requires you to specify if your cqrs call is command or query?"
      end

    end

    #outbound of ruggy

    #outbound of gitlapse 
    env[:lapses] = [{:lapse_id =>"#{start_blob_sha}_#{finish_blob_sha}", :start_blob_content => "", :finish_blob_content => "", :lapse => "thecontentofthelapse to be viewed in the browser", :lapse_metadata => "json stuff"}]

    def generate_lapses_hash commits, filepath
      commits.each do |commit|
	#find the blob of the filepath
	#
      end
    end

    def clone_repo clone_url, local_repo_path, filepath
      Rugged::Repository.clone_at(@clone_url, @local_repo_path)
      @repo = Rugged::Repository.new(@local_repo_path)
    end

=begin
      tab = []
      walker = Rugged::Walker.new(repo)
      walker.sorting(Rugged::SORT_DATE)
      walker.push(repo.head.target)
      walker.each do |commit|
	#if commit.diff(paths: ["README.md"]).size > 0
	if commit.diff(paths: [filepath]).size > 0
	  tab.push(commit)
	end
      end
      puts "collection of all the commits that contain the :filepath specified in order"
      puts tab

      tab.each do |commit|
	p commit
	p commit.to_hash
	p commit.tree
	commit.tree.each_blob do |blob|
	  p blob
	  p blob.class
	  p blob.methods
	end
	#p commit.tree.methods
	#p commit.methods
      end
      #tab.must_equal "ss"
      #@blob_sha = ""
      #blob = repo.lookup params[:sha]
=end
  end
end
