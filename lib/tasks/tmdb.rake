namespace :tmdb do
  desc "Dumps TMDB Database (Long running task..)"
  task :dump => :environment do
    last_id = Tmdb::Movie.latest.id

    (1..last_id).each do |i|
      puts Tmdb::Movie.find(i)
    end
  end
end
