package api

import (
	"github.com/gin-gonic/gin"
	db "github.com/tranhuyducseven/Go-bank-app/db/sqlc"
)

type Server struct {
	store  db.Store
	router *gin.Engine
}

func NewServer(store db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	router.POST("/accounts", server.createAccount)
	router.GET("/accounts/:id", server.getAccount)
	router.GET("/accounts", server.listAccount)
    router.DELETE("/accounts", server.deleteAccount)
    router.PATCH("/accounts", server.updateAccount)

	server.router = router
	return server
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
