package main

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
	"github.com/tranhuyducseven/Go-bank-app/api"
	db "github.com/tranhuyducseven/Go-bank-app/db/sqlc"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://root:seven@localhost:5432/bank_app?sslmode=disable"
	serverAddress = "0.0.0.0:3000"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to the db...:", err)

	}
	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot connect to the server...", err)
	}
}
