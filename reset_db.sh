#!/bin/bash
echo "Droping Data Bases"
rails db:drop
echo "Creating Data Bases"
rails db:create
echo "Migrating"
rails db:migrate
echo "Seeding"
rails db:seed --trace
