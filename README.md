webFinder
=========

Inspired by Tim Bray's [Wide Finder Project](https://www.tbray.org/ongoing/When/200x/2008/05/01/Wide-Finder-2).

The goal is to learn about various models of concurrency by posing a problem that requires concurrent IO (fetching web pages) and concurrent processing (parsing the Open Graph info of the web page), then writing solutions using differing models for managing concurrency

The Problem

Read URLs from a redis list, then write the results to a redis hash. Once all of the URLs have been fetched and processed push a message onto a redis list used to signal completion. 
