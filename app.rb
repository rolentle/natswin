require 'sinatra'

get '/' do
    game = %x{mlb games --date "yesterday" | grep Nationals}.split("\t")
    teams = game[1].split(" ")
    score = game[-1].delete("\n").split("-")
    results = [ [teams[0], score[0] ], [teams[3], score[1] ] ]

    if results[0][0] == "Nationals" && results[0][1] > results[1][1]
      @result_answer  = "Hell yeah, they beat #{results[1][0]}, #{results[0][1]} to #{results[1][1]}"
    elsif results[1][0] == "Nationals" && results[0][1] < results[1][1]
      @result_answer = "Hell yeah, they beat #{results[0][0]}, #{results[1][1]} to #{results[0][1]}"
    elsif results[0][0] == "Nationals" && results[0][1] < results[1][1]
      @result_answer =  "Nah, they lost to the #{results[1][0]}, #{results[1][1]} to #{results[0][1]}"
    elsif results[1][0] == "Nationals" && results[0][1] > results[1][1]
      @result_answer = "Nah, they lost to the #{results[0][0]}, #{results[0][1]} to #{results[1][1]}"
    end
   
    return @result_answer
  erb :index
end
