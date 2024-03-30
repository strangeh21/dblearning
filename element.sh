#!/bin/bash

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
  exit 0
fi  

# Check if input is numeric
if [[ $1 =~ ^[0-9]+$ ]]
then
  SEARCH_QUERY="atomic_number=$1"
else
  SEARCH_QUERY="name='$1' or symbol='$1'"
fi

PSQL="psql -U freecodecamp -d periodic_table -X -t -c"
RESPONSE=$($PSQL "select * from properties full join elements using(atomic_number) full join types using(type_id) where $SEARCH_QUERY")
if [[ -z $RESPONSE ]]
then
  echo I could not find that element in the database.
  exit 0
fi

echo "$RESPONSE" | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR SYMBOL BAR NAME BAR TYPE
do
  # The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
