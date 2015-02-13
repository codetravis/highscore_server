require 'sinatra'

set :public_folder, File.dirname(__FILE__) + "/html5"

get '/' do
    response.headers['Access-Control-Allow-Origin'] = "*"
    high_scores = File.read('highscores.txt')
    body high_scores
end

post '/' do
     score_list = []
     score_file = File.open('highscores.txt', 'rw')
     # parse score file into an array of hashes
     score_file.each_line do |line|
       line_fields = line.split(":")
       score_list.push({initials: line_fields[0], score: line_fields[1]})
     end
     # parse data passed in from game into hash
     player_score = data.split(":")
     # see if score is higher than any of our stored scores
     score_list.each do |high_score|
       if player_score[1] > high_score[:score]
         high_score[:initials] = player_score[0]
	 high_score[:score] = player_score[1]
	 break
       end
       # write new scores to file
       score_file.write(high_score[:initials] + ":" + high_score[:score])       
     end
end