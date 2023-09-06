package handler

import (
	"log"
	"time"
)

type Handler struct {
	Scraper   IScraper
	Datastore IDatastore
}

type IDatastore interface {
	ReplaceWithNewRecords([]FightRecord) error
}

type IScraper interface {
	GetResultsFromUrl() ([]FightRecord, error)
}

type FightRecord struct {
	DateTime time.Time
	Headline string
}

func (h Handler) HandleRequest() {
	log.Println("Starting handler...")

	log.Println("Fetching results from URL...")
	records, err := h.Scraper.GetResultsFromUrl()
	if err != nil {
		log.Panic(err)
	}
	log.Printf("Scraped data:\n%#v\n", records)

	log.Println("Replacing records in datastore...")
	err = h.Datastore.ReplaceWithNewRecords(records)
	if err != nil {
		log.Panic(err)
	}

	log.Println("Lambda function complete.")
}
