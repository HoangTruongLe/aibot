namespace :deploy do
  desc 'Run the precompile task locally and upload to server'
  task :precompile_locally_archive do
    on roles(:app) do
      run_locally do
        if RUBY_PLATFORM =~ /(win32)|(i386-mingw32)/
          execute 'del "tmp/assets.tar.gz"' rescue nil
          execute 'rd /S /Q "public/assets/"' rescue nil

          # precompile
          with rails_env: fetch(:rails_env) do
            execute 'rake assets:precompile'
          end
          #execute "RAILS_ENV=#{rails_env} rake assets:precompile"

          # use 7zip to archive
          execute '7z a -ttar assets.tar public/assets/'
          execute '7z a -tgzip assets.tar.gz assets.tar'
          execute 'del assets.tar'
          execute 'move assets.tar.gz tmp/'
        else
          execute 'rm tmp/assets.tar.gz' rescue nil
          execute 'rm -rf public/assets/*'

          with rails_env: fetch(:rails_env) do
            execute 'rake assets:precompile'
          end

          execute 'touch assets.tar.gz && rm assets.tar.gz'
          execute 'tar zcvf assets.tar.gz public/assets/'
          execute 'mv assets.tar.gz tmp/'
        end
      end

      # Upload precompiled assets
      execute 'rm -rf public/assets/*'
      upload! "tmp/assets.tar.gz", "#{release_path}/assets.tar.gz"
      execute "cd #{release_path} && tar zxvf assets.tar.gz && rm assets.tar.gz"
    end
  end

  # before :publishing, :precompile_locally_archive
end
