#!/usr/bin/env bats

# Author: David McCue

@test "docker: env DOCKER_HOST set" {
  run docker ps
  [ -n "$DOCKER_HOST" ]
  [ $status -eq 0 ]
}

@test "docker: kill existing container" {
  run docker rm -f ks-restserver
}

@test "setup: symlinks" {
  mkdir -p cli
  run ln -sf ../client.py cli/back
  run ln -sf ../client.py cli/backer
  run ln -sf ../client.py cli/list
  run ln -sf ../client.py cli/project
}

@test "docker: start rest container" {
  run docker run --name ks-restserver -p 8080:8080 -d ks-restserver
  [ $status -eq 0 ]
}

@test "setup: Check connectivity to REST server" {
  run nc -zw1 localhost 8080
  [ $status -eq 0 ]
}

@test "project: Check we can add a project" {
  run cli/project Awesome_Sauce 500
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Added Awesome_Sauce project with target of \$500" ]
}

@test "project: Check project added" {
  run cli/list Awesome_Sauce
  [ $status -eq 0 ]
}

@test "project: name short limit" {
  run cli/project abc 500
  [ $status -eq 1 ]
  [ "$output" = "ERROR: Project name validation error" ]
}

@test "project: name long limit" {
  run cli/project twentytwentytwentytwe 500
  [ $status -eq 1 ]
  [ "$output" = "ERROR: Project name validation error" ]
}

@test "project: name invalid char" {
  run cli/project invalid^char 500
  [ $status -eq 1 ]
  [ "$output" = "ERROR: Project name validation error" ]
}

@test "project: amount dollar test" {
  run cli/project amounttest1 500
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Added amounttest1 project with target of \$500" ]
}

@test "project: amount cent test" {
  run cli/project amounttest2 0.01
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Added amounttest2 project with target of \$0.01" ]
}

@test "back: Check we can back a project" {
  run cli/back John Awesome_Sauce 4111111111111111 50
  echo "$output"
  [ "$status" -eq 0 ]
  [ $output = "John backed project Awesome_Sauce for \$50" ]
}

@test "back: Check for credit card validation" {
  run cli/back Sally Awesome_Sauce 1234567890123456 10
  [ $output = "ERROR: This card is invalid" ]
  [ $status -eq 1 ]
}

@test "back: Check for credit card fraud" {
  run cli/back Jane Awesome_Sauce 4111111111111111 50
  [ $output = "ERROR: That card has already been added by another user!" ]
  [ $status -eq 1 ]
}

@test "back: Check for successful backer" {
  run cli/back Jane Awesome_Sauce 5555555555554444 50
  [ $output = "Jane backed project Awesome_Sauce for \$50" ]
  [ $status -eq 0 ]
}

@test "list: Check for project listing" {
  run cli/list Awesome_Sauce
  [ "${lines[0]}" = "-- John backed for \$50" ]
  [ "${lines[1]}" = "-- Jane backed for \$50" ]
  [ "${lines[2]}" = "Awesome_Sauce needs \$400 more dollars to be successful" ]
  [ $status -eq 0 ]
}

@test "backer: Check backer listing" {
  run cli/backer Jane
  [ $output = "-- Backed Awesome_Sauce for \$50" ]
  [ $status -eq 0 ]
}

@test "db: List project table" {
  skip "debug use"
  run sqlite3 kickstarter.db "select * from project;"
  echo "$output"
  [ $status -ne 0 ]
}

@test "db: List transaction table" {
  skip "debug use"
  run sqlite3 kickstarter.db "select * from 'transaction';"
  echo "$output"
  [ $status -ne 0 ]
}
