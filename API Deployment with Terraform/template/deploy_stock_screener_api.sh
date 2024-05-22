#! /bin/bash
# shellcheck disable=SC2164
cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install python3 python3-pip net-tools
yes | sudo apt install python3-scrapy
yes | sudo apt install python3-flask
yes | sudo apt install python3-twisted

git clone https://github.com/Suraj01Dev/stock_screener_api.git
sleep 20
# shellcheck disable=SC2164
cd stock_screener_api
python3 app.py &
