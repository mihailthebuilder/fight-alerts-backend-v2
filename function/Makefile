build:
	go build -o ./bin/app

test:
	go test ./ ./scraper ./lambda_handler ./datastore -coverprofile=./test_results/coverage.out
	go tool cover -html=./test_results/coverage.out -o ./test_results/coverage.html