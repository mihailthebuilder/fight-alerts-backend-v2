package handler

import (
	"github.com/stretchr/testify/mock"
)

type MockScraper struct {
	mock.Mock
}

func (s *MockScraper) GetResultsFromUrl() ([]FightRecord, error) {
	args := s.Called()
	return args.Get(0).([]FightRecord), args.Error(1)
}

type MockDatastore struct {
	mock.Mock
}

func (d *MockDatastore) ReplaceWithNewRecords(records []FightRecord) error {
	args := d.Called(records)
	return args.Error(0)
}
