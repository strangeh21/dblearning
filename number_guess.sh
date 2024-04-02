#!/bin/bash

PSQL="psql -X -U freecodecamp -d numbers_game -t -c"



MAIN() {
    # Ask user for username up to 22 char
    echo -e "\nEnter your username:"
    read USERNAME

    USERNAME_RESPONSE=$($PSQL "Select username from users where username='$USERNAME'")
    WELCOME_MESSAGE "$USERNAME_RESPONSE"
    PLAY_NUMBERS_GAME
}


PLAY_NUMBERS_GAME() {
    RANDOM_NUMBER=$((1 + $RANDOM % 1000))
    NUMBER_OF_GUESSES=0
    echo "Guess the secret number between 1 and 1000:"
    while true; do
        ((NUMBER_OF_GUESSES++))
        read USER_GUESS
        if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]; then
            echo "That is not an integer, guess again:"
        elif [[ $USER_GUESS == $RANDOM_NUMBER ]]; then
            echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"
            break
        elif [[ $USER_GUESS < $RANDOM_NUMBER ]]; then
            echo "It's higher than that, guess again:"
        elif [[ $USER_GUESS > $RANDOM_NUMBER ]]; then
            echo "It's lower than that, guess again:"
        fi
    done

    # Add to database
    USER_ID=$($PSQL "select user_id from users where username='$USERNAME'")
    ADD_GAME_TO_DB_RESPONSE=$($PSQL "insert into games(user_id, guesses) values($USER_ID, $NUMBER_OF_GUESSES)")
}
  
WELCOME_MESSAGE() {
    USERNAME_RESPONSE=$1
    # If existing user:
    if [[ ! -z $USERNAME_RESPONSE ]]; then
        USERNAME_GAME_STATS=$($PSQL "select count(username) as total_games, min(guesses) as best_score from games inner join users using(user_id) where username='$USERNAME'")
        echo "$USERNAME_GAME_STATS" | while read TOTAL_GAMES BAR BEST_SCORE
        do
            echo "Welcome back, $USERNAME! You have played $TOTAL_GAMES games, and your best game took $BEST_SCORE guesses."
        done
    else
        # Add to DB
        ADD_TO_DB_RESPONSE=$($PSQL "insert into users(username) values('$USERNAME')")
        echo "Welcome, $USERNAME! It looks like this is your first time here."
    fi
}


MAIN
