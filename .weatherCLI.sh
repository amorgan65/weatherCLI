#!/bin/bash

function temp() {
  #latitude float from first line
  LAT=$(./whereami | head -n 1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
  #longitude lon float from second line
  LON=$(./whereami | sed -n '2 p' | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')

  KEY="0f17b4981ed7156a5f38d31a86bbe66a"  #<--- API Key in quotes here.

  URL="https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&units=imperial&appid=${KEY}"

  curl -s --create-dirs -o weatherData.json --output-dir /usr/local/bin/weatherData ${URL} -H "Accept: application/json"

  file_path="/usr/local/bin/weatherData/weatherData.json"

  temp=$(jq '.main.temp' ${file_path})
  location=$(jq '.name' ${file_path})

  echo "It is ${temp} degrees in ${location}."
  
  rm ${file_path} 
