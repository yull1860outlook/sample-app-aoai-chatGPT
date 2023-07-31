#!/bin/bash

echo ""
echo "Restoring frontend npm packages"
echo ""
cd frontend
apt install npm -y
npm install
if [ $? -ne 0 ]; then
    echo "Failed to restore frontend npm packages"
    exit $?
fi

echo ""
echo "Building frontend"
echo ""
npm run build
if [ $? -ne 0 ]; then
    echo "Failed to build frontend"
    exit $?
fi

cd ..
#. ./scripts/loadenv.sh

echo ""
echo "Starting backend"
echo ""
python  -m flask run --port=8000 --host=0.0.0.0 --reload --debug
if [ $? -ne 0 ]; then
    echo "Failed to start backend"
    exit $?
fi
