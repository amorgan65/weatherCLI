#!/bin/bash

function temp() {
  #latitude float from first line
  LAT=$(./whereami | head -n 1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
  #longitude lon float from second line
  LON=$(./whereami | sed -n '2 p' | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')

  ID=""  #<--- API ID Key in quotes here.

  URL="https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&units=imperial&appid=${ID}"

  response=$(curl -s ${URL} | jq '.main.temp')

  echo "It is ${response} degrees."
}

