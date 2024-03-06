#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo "$($PSQL "TRUNCATE TABLE games, teams")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # If first line, continue
  if [[ $YEAR == "year" && $ROUND == "round" && $WINNER == "winner" ]]
  then
    echo This is the first line.
    continue
  fi
  
  # get winner_id from teams db
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  
  # If winner_id is not in teams db
  if [[ -z $WINNER_ID ]]
  then
    # Add winner_id to teams db
    INSERT_WINNER_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
	WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  fi

  # get opponent_id from teams db
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  
  # If opponent_id is not in teams db
  if [[ -z $OPPONENT_ID ]]
  then
    # Add opponent_id to teams db
    INSERT_OPPONENT_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
	OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  fi

  
  
  # Add game to games database
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES($YEAR, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS, '$ROUND')")
  
  


done