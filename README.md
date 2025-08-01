# TourSolution BackEnd API

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Docker](https://docs.docker.com/get-docker/) (version 25.0.2 or higher)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 1.25.3 or higher)

## Getting Started

### Installation

To get started, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/TourSolutionDev/BackEnd
   ```

2. Navigate to the project directory:

   ```bash
   cd BackEnd
   ```

3. Rename the `.env.example` file to `.env`:

   ```bash
   cp .env.example .env
   ```

4. Update the `.env` file with the appropriate values:

   ```bash

   POSTGRES_USER=your_username
   POSTGRES_PASSWORD=your_password
   POSTGRES_DB=your_database_name
   ```

5. Build the Docker containers:

   ```bash
   docker-compose build
   ```

### Usage

To run the project, use the following commands:

1. Start the Docker containers:

   ```bash
   docker-compose up
   ```

2. Install the dependencies:

   ```bash
   docker-compose run app bundle install
   ```

3. Set up the database:

   ```bash
   docker-compose run app rails db:create
   docker-compose run app rails db:migrate
   ```

4. Start the Rails server:

   ```bash
   docker-compose up
   ```

5. Access the application at `http://localhost:3000` or `http://127.0.0.1:3000` in your web browser.

6. To stop the Docker containers, use the following command:

   ```bash
   docker-compose down
   ```
