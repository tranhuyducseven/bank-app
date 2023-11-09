# Gin template

## Prerequisite: *docker, docker-compose, [migrate](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate)*, sqlc, mockgen

- Download MIGRATE CLI:
  1. Linux
  
    ```bash
    curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz
    ```

    ```bash
    sudo ln -sf [directory]/migrate /usr/bin/migrate
    ```

    2. Mac
    
    ```bash
    brew install golang-migrate 
    ```
- Download SQLC:

    ```bash
    go install github.com/kyleconroy/sqlc/cmd/sqlc@latest
    ```

- Download MOCKGEN:

    ```bash
    go install go.uber.org/mock/mockgen@latest
    ```

## Before start the project

- Name of module is placed in `go.mod`, you need rename it.
- Fix all imports in all files with "re-named" module
- This project use **viper** for loading configs, make sure that you checked them
  - `app.env`
  - `.docker.env`
  - `docker-compose.dev`
  - `docker-compose`
  - `Makefile`
- It uses **sqlc** tool for generating **.go** files at `db/sqlc` directory. It makes easier for interacting with database layer.
  > Just add sql scripts in `db/query` directory, each file corresponding one entity.
- It uses **paseto** for token generation, you can add another token generator that you want, it has an interface named **Maker** at `token/maker.go`

## Project structure

```null
📦 api                      # Business layer
 ┣ 📜 server.go             # Init routing
 ┗ 📜 [sample].go         # Sample API   
 ┣ 📜 middleware.go         # Middleware
 ┗ 📜 validator.go          # Validator for Gin
 ┣ 📜 main_test.go          # Test all apis
📦 db                       # Database layer
 ┣ 📂 initdb                  # Init sql (optional)
 ┃ ┣ 📂 func_proc             # function and procedure for database
 ┃ ┣ 📂 trigger               # trigger for database
 ┃ ┗ 📜 [sample].sql             
 ┣ 📂 migration              # Contains migration files
 ┣ 📂 mock                   # Mock db (auto generating) 
 ┣ 📂 query                  # Define entities here
 ┃ ┗ 📜 [sample].sql               
 ┣ 📂 sqlc                   # Database caller (auto-generating)
 ┃ ┣ 📜 db.go, models.go, querier.go  # (auto-generating)          
 ┃ ┣ 📜 [sample].go                   # (auto-generating)               
 ┃ ┗ 📜 store.go             # Database storage (tx logics)
 ┣ 📂 token                  # token
 ┣ 📂 utils                  
 ┣ 📜 main.go                # Init sever and db, start here
 ┣ 📜 .docker.env            
 ┗ 📜 app.env              
```

## How to start this project?

- Install dependencies

  ```bash
  go get -u -v  all
  ```

- Start the app (For the first running):

```bash
make bootstrap
```

## After added new entities, you must run these commands for re-generating **models**

```bash
make sqlc && make mock
```
