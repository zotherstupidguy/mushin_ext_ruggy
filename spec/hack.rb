# transform a Rugged::Repository into a hash
# this will make middlewares don't care about the underlining implmentation of how to interface with git
#NOTE maybe ruggy should be called mushin_ext_repo

#get everything i want to include alone as a hash, then merge hashs
require 'rugged'
require "json"

#env[:repo_slug][:branch_name][:commit_sha][:tree_path]
#env[:repo_slug][:branch_name][:commit_sha][:blob_path]
#
#env[:repo_slug][:branch_name][:commit_sha][:file_path]


@repo = Rugged::Repository.new('./../sinatra')
#p @repo.methods

@repo.each_id do |id|
  #  p @repo.lookup id
end

tab = []
walker = Rugged::Walker.new(@repo)
walker.sorting(Rugged::SORT_DATE)
walker.push(@repo.head.target)
walker.each do |commit|
  if commit.diff(paths: ["README.md"]).size > 0
  #if commit.diff(paths: [filepath]).size > 0
    tab.push(commit)
  end
end
puts "collection of all the commits that contain the :filepath specified in order"
puts tab

tab.each do |commit|
  #p commit
  #p commit.tree
  if commit.diff(paths: ["README.md"]).size > 0
  p "---------------------------------"
    p commit
    p commit.to_hash
  p "---------------------------------"
  end

  #commit.tree.each_blob do |blob|
  #  p blob
  #  p blob.class
  #  p blob.methods
  #end
  #p commit.tree.methods
  #p commit.methods
end

#tab.must_equal "ss"
#@blob_sha = ""
#blob = repo.lookup params[:sha]


#p @repo.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = @repo.instance_variable_get(var) }

=begin
def to_hash obj
  Hash[obj.instance_variables.map { |key|
    variable = obj.instance_variable_get key
    [key.to_s[1..-1].to_sym,
     if variable.respond_to? <:some_method> then
       hashify variable
    else
      variable
    end
    ]
  }]
end #}}} 

p to_hash(@repo)
@repo.methods.each do |m|
  puts m
end

@repo.branches.each do |b|
  p b
  p b.methods
end
=end
#p @repo.branches.methods
#p @repo.branches
