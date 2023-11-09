migration_path = db/migration
db_source = postgresql://root:secret@localhost:5432/bank_app?sslmode=disable

boot:
	docker-compose up -d --remove-orphans
down:
	docker-compose down -v --remove-orphans
dropmaindb:
	docker exec -it postgres dropdb bank_app 
createdb:
	docker exec -it postgres createdb --username=root --owner=root bank_app 
dropdb:
	docker exec -it postgres dropdb bank_app 

migrateup:
	migrate -path $(migration_path) -database "$(db_source)" -verbose up
migrateup1:
	migrate -path $(migration_path) -database "$(db_source)" -verbose up 1
migratedown:
	migrate -path $(migration_path) -database "$(db_source)" -verbose down
migratedown1:
	migrate -path $(migration_path) -database "$(db_source)" -verbose down 1

sqlc:
	sqlc generate
test:
	go test -v -cover ./...
psql:
	docker exec -it postgres psql -U root -d bank_app
server:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/tranhuyducseven/bank-app/db/sqlc Store


.PHONY: boostrap postgres createdb dropdb migrateup migratedown migrateup1 migratedown1  sqlc test psql server mock 

