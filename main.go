package main

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
	"github.com/tranhuyducseven/Go-bank-app/api"
	db "github.com/tranhuyducseven/Go-bank-app/db/sqlc"
	"github.com/tranhuyducseven/Go-bank-app/util"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://root:seven@localhost:5432/bank_app?sslmode=disable"
	serverAddress = "0.0.0.0:3000"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to the db...:", err)

	}
	store := db.NewStore(conn)

	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot initialize the server...", err)
	}
	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot connect to the server...", err)
	}
}
