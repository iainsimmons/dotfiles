#!/bin/bash

sudo cp ~/dotfiles/.config/evremap/evremap.service /usr/lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable evremap.service
sudo systemctl start evremap.service
