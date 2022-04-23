#!/usr/env/bin bash

main(){
    read -p "Enter website: " website
    response=$(curl -I $website/robots.txt | head -n 1)
    if [[ $response == *"200"* ]]; then
        curl $website/robots.txt
    elif [[ $response == *"301"* ]]; then
        redirwebsite = $(curl -I $website/robots.txt | grep "location:" | cut -d " " -f 2)
        curl $redirwebsite/robots.txt
    elif [[ $response == *"302"* ]]; then
        redirwebsite = $(curl -I $website/robots.txt | grep "location:" | cut -d " " -f 2)
        curl $redirwebsite/robots.txt
    elif [[ $response == *"404"* ]]; then
        echo "404 Error"
    fi
}
main
