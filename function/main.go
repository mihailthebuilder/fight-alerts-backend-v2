package main

import (
	"database/sql"
	"fight-alerts-scraper/datastore"
	handler "fight-alerts-scraper/lambda_handler"
	"fight-alerts-scraper/scraper"
	"fmt"
	"os"

	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	s := scraper.Scraper{Url: scraper.MmaUrl}

	d := setUpDatastore()

	lh := handler.Handler{Scraper: s, Datastore: d}

	lambda.Start(lh.HandleRequest)
}

func setUpDatastore() datastore.Datastore {
	host := os.Getenv("RDS_HOST")
	password := os.Getenv("RDS_PASSWORD")
	username := os.Getenv("RDS_USERNAME")

	cs := buildConnectionString(host, password, username, "FightAlertsDb", 5432)
	db, _ := sql.Open("postgres", cs)

	return datastore.Datastore{Db: db}
}

func buildConnectionString(host, password, username, dbName string, port int) string {
	return fmt.Sprintf(
		"host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		host, port, username, password, dbName,
	)
}
