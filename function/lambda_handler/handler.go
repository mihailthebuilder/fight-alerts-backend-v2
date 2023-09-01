package handler

import (
	"fmt"
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
	records, err := h.Scraper.GetResultsFromUrl()
	if err != nil {
		log.Panic(err)
	}
	fmt.Printf("Scraped data:\n%#v\n", records)

	err = h.Datastore.ReplaceWithNewRecords(records)
	if err != nil {
		log.Panic(err)
	}
}
