bootstrapdb:
	docker-compose up -d --remove-orphans
createdb:
	docker exec -it  createdb --username=root --owner=root bank_app

dropdb:
	docker exec -it  dropdb bank_app

migrateup:
	migrate -path db/migration -database "postgresql://root:seven@localhost:5432/bank_app?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:seven@localhost:5432/bank_app?sslmode=disable" -verbose down

sqlc:
	sqlc generate
test:
	go test -v -cover ./...
psql:
	docker exec -it postgres12 psql -U root -d bank_app

.PHONY: boostrapdb postgres createdb dropdb migrateup migratedown sqlc test psql
