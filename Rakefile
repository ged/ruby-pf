#!/usr/bin/env rake

begin
	require 'hoe'
	require 'rake/extensiontask'
rescue LoadError => err
	abort "This Rakefile requires hoe and rake-compiler (gem install hoe rake-compiler)"
end

require 'rake/clean'

GEMSPEC = 'ruby-pf.gemspec'


Hoe.plugin :mercurial
Hoe.plugin :signing
Hoe.plugin :deveiate

Hoe.plugins.delete :rubyforge

hoespec = Hoe.spec 'ruby-pf' do |spec|
	spec.readme_file = 'README.md'
	spec.history_file = 'History.md'
	spec.extra_rdoc_files = FileList[ '*.rdoc', '*.md' ]
	spec.license 'BSD-3-Clause'
	spec.urls = {
		home:   'http://deveiate.org/projects/ruby-pf',
		code:   'http://bitbucket.org/ged/ruby-pf',
		docs:   'http://deveiate.org/code/ruby-pf',
		github: 'http://github.com/ged/ruby-pf',
	}

	spec.developer 'Michael Granger', 'ged@FaerieMUD.org'

	spec.dependency 'loggability', '~> 0.11'
	spec.dependency 'bit-struct', '~> 0.15'

	spec.dependency 'rake-compiler',           '~> 0.9', :developer
	spec.dependency 'hoe-deveiate',            '~> 0.3', :developer
	spec.dependency 'simplecov',               '~> 0.7', :developer
	spec.dependency 'rdoc-generator-fivefish', '~> 0.1', :developer

	spec.require_ruby_version( '>=2.2.0' )
	spec.hg_sign_tags = true if spec.respond_to?( :hg_sign_tags= )
	spec.check_history_on_release = true if spec.respond_to?( :check_history_on_release= )

	self.rdoc_locations << "deveiate:/usr/local/www/public/code/#{remote_rdoc_dir}"
end


ENV['VERSION'] ||= hoespec.spec.version.to_s

# Rake-compiler task
Rake::ExtensionTask.new( 'pf_ext' )
task :spec => :compile

CLOBBER.include( 'tmp' )


# Run the tests before checking in
task 'hg:precheckin' => [ :check_history, :check_manifest, :gemspec, :spec ]

task :test => :spec

# Rebuild the ChangeLog immediately before release
task :prerelease => 'ChangeLog'
CLOBBER.include( 'ChangeLog' )

desc "Build a coverage report"
task :coverage do
	ENV["COVERAGE"] = 'yes'
	Rake::Task[:spec].invoke
end
CLOBBER.include( 'coverage' )


# Use the fivefish formatter for docs generated from development checkout
if File.directory?( '.hg' )
	require 'rdoc/task'

	Rake::Task[ 'docs' ].clear
	RDoc::Task.new( 'docs' ) do |rdoc|
	    rdoc.main = "README.rdoc"
		rdoc.markup = 'markdown'
	    rdoc.rdoc_files.include( "*.rdoc", "ChangeLog", "lib/**/*.rb" )
	    rdoc.generator = :fivefish
		rdoc.title = 'ruby-pf'
	    rdoc.rdoc_dir = 'doc'
	end
end

task :gemspec => GEMSPEC
file GEMSPEC => __FILE__
task GEMSPEC do |task|
	spec = $hoespec.spec
	spec.files.delete( '.gemtest' )
	spec.signing_key = nil
	spec.cert_chain = ['certs/ged.pem']
	spec.version = "#{spec.version}.pre#{Time.now.strftime("%Y%m%d%H%M%S")}"
	File.open( task.name, 'w' ) do |fh|
		fh.write( spec.to_ruby )
	end
end

CLOBBER.include( GEMSPEC.to_s )

