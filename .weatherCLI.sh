#!/bin/bash


KEY=""  #<--- API Key in quotes here.


function temp() {
  #latitude float from first line
  LAT=$(./whereami | head -n 1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
  #longitude lon float from second line
  LON=$(./whereami | sed -n '2 p' | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')

  URL="https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&units=imperial&appid=${KEY}"

  curl -s --create-dirs -o weatherData.json --output-dir /usr/local/bin/weatherData ${URL} -H "Accept: application/json"

  file_path="/usr/local/bin/weatherData/weatherData.json"

  temp=$(jq '.main.temp' ${file_path})
  location=$(jq -r '.name' ${file_path})

  echo "It is ${temp}°F right now in ${location}."

  rm ${file_path} 
}


function weather() {
  #latitude float from first line
  LAT=$(./whereami | head -n 1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
  #longitude lon float from second line
  LON=$(./whereami | sed -n '2 p' | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')

  URL="https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&units=imperial&appid=${KEY}"

  curl -s --create-dirs -o weatherData.json --output-dir /usr/local/bin/weatherData ${URL} -H "Accept: application/json"

  file_path="/usr/local/bin/weatherData/weatherData.json"

  temp=$(jq '.main.temp' ${file_path})
  location=$(jq -r '.name' ${file_path})
  wind_speed=$(jq '.wind.speed' ${file_path})
  wind_temp=$(jq '.wind.deg' ${file_path})
  forecast=$(jq -r '.weather[].description' ${file_path})
  humidity=$(jq '.main.humidity' ${file_path})

  echo "It is ${temp}°F right now in ${location}."
  echo "Currently: ${forecast}"
  echo "Wind: ${wind_speed} mph & ${wind_temp}°F"
  echo "Humidity: ${humidity}%"

  rm ${file_path}
}
