# Cocktail API Backend Setup Guide

### The api is avaliable at: [Cocktail API](https://api.lis.rocks)

## System Architecture

- **Backend**: Node.js application using Adonis.js framework
- **Database**: PostgreSQL
- **Deployment**: Docker containers on Raspberry Pi
- **CI/CD**: GitHub Actions workflow for automated deployment

## Initial Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/foxjustfox/backend-cocktail-api.git
   cd backend-cocktail-api
   ```
2. Install dependencies:

   ```bash
   npm install
   ```
3. Configure environment variables:

   ```bash
   cp .env.example .env
   ```

   I have edited the `.env` file with your database credentials and other configurations.
4. Run migrations:

   ```bash
   node ace migration:run
   ```
5. Seed the database:

   ```bash
   node ace db:seed
   ```

## Docker Configuration

The application is containerized using Docker with the following configuration:

1. **Dockerfile**:

   - Uses Node.js Alpine image
   - Copies application files
   - Builds the Adonis.js application
   - Exposes port 3333
   - Starts the application with `npm start`

## Deployment Configuration

The deployment is automated through GitHub Actions:

1. **Workflow Trigger**:

   - Pushed to main branch
   - Manual workflow dispatch
2. **Deployment Process**:

   - SSH into Raspberry Pi
   - Pull latest code from GitHub
   - Stop existing containers
   - Build and start new containers

## Complete Deployment Workflow

The final deployment workflow (`main.yml`):

```yaml
name: CI and Deploy

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Raspberry Pi via SSH
        uses: appleboy/ssh-action@v0.1.4
        with:
          host: ${{ secrets.RPI_HOST }}
          username: ${{ secrets.RPI_USER }}
          password: ${{ secrets.RPI_SECRET }}
          script: |
            cd /home/****/******/server/apps/backend-cocktail-api
            git pull origin main
            docker-compose down
            docker-compose up -d --build
```

*Last updated: March 21, 2025*
