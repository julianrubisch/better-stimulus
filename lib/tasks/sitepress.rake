namespace :sitepress do
  namespace :pagefind do
    desc "Compile the sitepress site and build a pagefind index"
    task build: :environment do
      site = Sitepress::Site.new(root_path: "app/content")
      build_path = Rails.root.join("tmp/sitepress")
      pagefind_output_path = Rails.root.join("public/pagefind")

      puts "Purging output directory"
      FileUtils.rm_r build_path

      compiler = Sitepress::Compiler::Files.new(root_path: build_path, site:)

      compiler.compile

      puts <<~END

      Building Pagefind Index

      END

      system "npx pagefind --site #{build_path} --output-path #{pagefind_output_path}"
    end
  end
end

unless ENV["SKIP_SITEPRESS_BUILD"]
  if Rake::Task.task_defined?("assets:precompile")
    Rake::Task["assets:precompile"].enhance(["sitepress:pagefind:build"])
  end

  if Rake::Task.task_defined?("test:prepare")
    Rake::Task["test:prepare"].enhance(["sitepress:pagefind:build"])
  elsif Rake::Task.task_defined?("spec:prepare")
    Rake::Task["spec:prepare"].enhance(["sitepress:pagefind:build"])
  elsif Rake::Task.task_defined?("db:test:prepare")
    Rake::Task["db:test:prepare"].enhance(["sitepress:pagefind:build"])
  end
end
