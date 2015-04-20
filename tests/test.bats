#!/usr/bin/env bats

# Author: David McCue

@test "Reset database" {
  run python dbreset.py
  [ $status -eq 0 ]
}

@test "Setup symlinks" {
  run ln -sf cli/client.py cli/back
  run ln -sf cli/client.py cli/backer
  run ln -sf cli/client.py cli/list
  run ln -sf cli/client.py cli/project
}

@test "Check connectivity to REST server" {
  run nc -zw1 localhost 8080
  [ $status -eq 0 ]
}

@test "Check we can add a project" {
  run cli/project Awesome_Sauce 500
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Added Awesome_Sauce project with target of \$500" ]
}

@test "Check project added" {
  run cli/list Awesome_Sauce
  [ $status -eq 0 ]
}

@test "Check we can back a project" {
  run cli/back John Awesome_Sauce 4111111111111111 50
  echo "$output"
  [ "$status" -eq 0 ]
  [ $output = "John backed project Awesome_Sauce for \$50" ]
}

@test "Check for credit card validation" {
  run cli/back Sally Awesome_Sauce 1234567890123456 10
  [ $output = "ERROR: This card is invalid" ]
  [ $status -eq 1 ]
}

@test "Check for credit card fraud" {
  run cli/back Jane Awesome_Sauce 4111111111111111 50
  [ $output = "ERROR: That card has already been added by another user!" ]
  [ $status -eq 1 ]
}

@test "Check for successful backer" {
  run cli/back Jane Awesome_Sauce 5555555555554444 50
  [ $output = "Jane backed project Awesome_Sauce for \$50" ]
  [ $status -eq 0 ]
}

@test "Check for project listing" {
  run cli/list Awesome_Sauce
  [ "${lines[0]}" = "-- John backed for \$50" ]
  [ "${lines[1]}" = "-- Jane backed for \$50" ]
  [ "${lines[2]}" = "Awesome_Sauce needs \$400 more dollars to be successful" ]
  [ $status -eq 0 ]
}

@test "List project table" {
  skip "debugging"
  run sqlite3 kickstarter.db "select * from project;"
  echo "$output"
  [ $status -ne 0 ]
}

@test "List transaction table" {
  skip "debugging"
  run sqlite3 kickstarter.db "select * from 'transaction';"
  echo "$output"
  [ $status -ne 0 ]
}
