#!/bin/bash

# Start the backend service with pm2
cd backend/
pm2 start yarn --name "backend-service" -- dev

# Start the admin service with pm2
cd ../admin/
pm2 start yarn --name "admin-service" -- start-mac