package handler

import (
	"fmt"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
)

func TestHandler_HandleRequest(t *testing.T) {
	tests := []struct {
		name           string
		scraperError   error
		datastoreError error
		wantErr        bool
	}{
		{
			name:    "happy path",
			wantErr: false,
		},
		{
			name:         "scraper error",
			scraperError: fmt.Errorf("fake err"),
			wantErr:      true,
		},
		{
			name:           "scraper error",
			datastoreError: fmt.Errorf("fake err"),
			wantErr:        true,
		},
	}
	for _, tt := range tests {

		firstRecord := FightRecord{Headline: "first", DateTime: time.Now()}
		secondRecord := FightRecord{Headline: "second", DateTime: time.Now()}
		records := []FightRecord{firstRecord, secondRecord}

		s := MockScraper{}
		s.On("GetResultsFromUrl").Return(records, tt.scraperError)

		d := MockDatastore{}
		d.On("ReplaceWithNewRecords", records).Return(tt.datastoreError)

		h := Handler{Scraper: &s, Datastore: &d}

		t.Run(tt.name, func(t *testing.T) {
			if tt.wantErr {
				assert.Panics(t, h.HandleRequest, "The code did not panic")
			} else {
				h.HandleRequest()
				s.AssertExpectations(t)
				d.AssertExpectations(t)
			}
		})
	}
}
