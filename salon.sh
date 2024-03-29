#!/bin/bash

PSQL="psql -U freecodecamp -d salon -t -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?"

MAIN_MENU() {
	# get which service user would like
	SERVICES=$($PSQL "SELECT service_id,name FROM services")
	echo "$SERVICES" | while IFS=' | ' read SERVICE_ID NAME
	do
		echo "$SERVICE_ID) $NAME"
	done
	read SERVICE_ID_SELECTED

	# Check DB for if it exists
	SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

	# If it doesn't exist, return to main menu
	if [[ -z $SERVICE_NAME ]]
	then
		echo -e "\nI could not find that service. What would you like today?"
		MAIN_MENU
	fi

	# get phone number
	echo -e "\nWhat's your phone number?"
	read CUSTOMER_PHONE

	# Check phone number in database and get customer ID
	CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

	# If no record:
	if [[ -z $CUSTOMER_NAME ]]
	then
		# Get customer name
		echo -e "\nI don't have a record for that phone number, what's your name?"
		read CUSTOMER_NAME

		# Insert details in database
		INSERT_CUSTOMER_RECORD=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
		CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
	fi

	CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
	# Get service time
	echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
	read SERVICE_TIME

	# Insert into database
	INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
	echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME,$CUSTOMER_NAME."
}

MAIN_MENU
