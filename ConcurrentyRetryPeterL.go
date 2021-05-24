package main

import (
	"fmt"
	"time"
	"errors"
	"sync"
	"math/rand"
	"math"

)

type Job = func() (string, error)

type Result struct{
	index int
	result string
	retry int
}

func main() {
	var tasks []func() (string, error)
	for i:=0; i< 200; i++ {
		tasks = append(tasks, TaskGenerator)
	}
	startTime := time.Now()
	results := ConcurrentRetry(tasks, 20, 2)
	elapsedTime := time.Since(startTime)

	count := 0
	for r := range(results) {
		fmt.Println("Result recieved from thread: ", r)
		if r.result == "Passed"{
		count++
		}
	}
	probabilityOfSuccess := 1.0 - math.Pow(probabilityOfFailure, float64(2))
	fmt.Println(math.Round(probabilityOfSuccess * float64(200)), " tasks that are theoretically expected.")
    fmt.Println(count, " out of ", 200, " tasks completed successfully.")
    fmt.Println("Took ", elapsedTime, "to complete.")
}
var probabilityOfFailure = 0.5
func TaskGenerator() (string, error) {
	x := rand.Float64()
	duration := time.Duration(rand.Intn(1e3)) * time.Millisecond
	time.Sleep(duration)

	if x <= probabilityOfFailure{
		return "Error", errors.New("Error")
	}
	return "Passed", nil
}


func worker(ID int, threads <- chan Job, results chan<- Result, Retry int, waitingFor * sync.WaitGroup){

	fmt.Println("Initiating task... Task ID: ", ID)

	for j := range threads {

		var r Result

		for i:=0; i < Retry; i++ {
			str, e := j()

			r = Result {
				index : ID,
				result: str,
				retry: i+1,
			}

			if e == nil {
				break
			}

		}

		results <- r

	}

	waitingFor.Done()

}

func ConcurrentRetry(tasks []func() (string, error), concurrent int, retry int) <- chan Result {
	threads := make(chan Job, len(tasks))
	results := make(chan Result, len(tasks))

	var waitingFor sync.WaitGroup

	fmt.Println("Starting", concurrent, "tasks")

	go func() {

		for _, j := range tasks {
			threads <- j
		}



		for x := 1; x <= concurrent; x++ {
			waitingFor.Add(1)
			go worker(x, threads, results, retry, &waitingFor)
	}

		for {
			if len(threads) == 0 {
				close(threads)
				break
			}
		}

		waitingFor.Wait()
		close(results)

	}()


	return results
}
