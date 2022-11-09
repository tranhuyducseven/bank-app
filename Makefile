bootstrap:
	docker-compose up -d --remove-orphans
dropmaindb:
	docker exec -it postgres dropdb bank_app 
createdb:
	docker exec -it postgres createdb --username=root --owner=root bank_app 
dropdb:
	docker exec -it postgres dropdb bank_app 

migrateup:
	migrate -path db/migration -database "postgresql://root:seven@localhost:5432/bank_app?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:seven@localhost:5432/bank_app?sslmode=disable" -verbose down

sqlc:
	sqlc generate
test:
	go test -v -cover ./...
psql:
	docker exec -it postgres psql -U root -d bank_app
server:
	go run main.go

.PHONY: boostrap postgres createdb dropdb migrateup migratedown sqlc test psql server

