# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 


# Overview of Our Project

"LayOn will change how people navigate the rough landscape of layoffs in today's world. Through real-time tracking, users gain instant insights into company layoffs, including detailed information on affected employees, timing, and reasons. Our platform offers in-depth analysis and trend tracking, allowing users to understand economic and cultural shifts impacting their job security. With personalized company profiles, individuals can assess their own risk and history of layoffs. Users can also chat with a supportive community forum to share experiences and insights, while our resource center allows users to have valuable tools and guidance to go through layoffs with resilience and confidence.




