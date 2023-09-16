package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

type User struct {
	Id        int    `json:"id"`
	Firstname string `json:"firstName"`
	Lastname  string `json:"lastName"`
	Email     string `json:"email"`
	Age       int    `json:"age"`
	Img       string `json:"image"`
	Ph        string `json:"phone"`
}
type GetUsersResponse struct {
	Users []User
}

func getUsersHandler(g *gin.Context) {
	httpClient := &http.Client{}
	resp, err := httpClient.Get("https://dummyjson.com/users")
	logger := log.Default()
	if err != nil {
		g.AbortWithStatus(http.StatusBadRequest)
		return
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)

	if err != nil {
		fmt.Println(err)
		g.AbortWithStatus(http.StatusBadRequest)
		return
	}

	var userApiResponse GetUsersResponse

	err = json.Unmarshal(body, &userApiResponse)

	if err != nil {
		fmt.Println(err)
		g.AbortWithStatus(http.StatusBadRequest)
		return
	}

	logger.Println("Resp", userApiResponse)

	g.JSON(http.StatusOK, gin.H{
		"data": userApiResponse,
	})
}

func main() {
	fmt.Println("This is the docker tutorial go server")

	router := gin.Default()

	router.Use(corsMiddleware())

	router.GET("/users", getUsersHandler)

	router.Run(":8080")
}

func corsMiddleware() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		ctx.Writer.Header().Set("Access-Control-Allow-Methods", "GET,POST,OPTIONS")
		ctx.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		ctx.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization, mode")

		if ctx.Request.Method == http.MethodOptions {
			ctx.AbortWithStatus(http.StatusOK)
			return
		}
		ctx.Next()
	}
}
