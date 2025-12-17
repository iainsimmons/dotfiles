#!/bin/bash

sudo cp evremap.service /usr/lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable evremap.service
sudo systemctl start evremap.service
