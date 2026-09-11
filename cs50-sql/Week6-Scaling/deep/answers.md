# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Random Partitioning distributes observations evenly to all the boats, helping balance storage and workload. Though observations from the same time range can be stored on different boats and range queries like finding all observations from midnight to 1am could be run on every boat. It improves load balancing but makes many queries.

## Partitioning by Hour

Partitioning by Hour makes time-based queries fast because observations from a specific time range are stored on a specific boat. So, if observations are huge during certain hours, one boat may receive more data than others which create an uneven distribution of storage and workload. This improves query performance but create load imbalance.

## Partitioning by Hash Value

Partitioning by Hash Value distributes observations evenly to all the boats. But range queries are not efficient cause observations from the same time period may be spread to all the boats. It requirs quering on every boat.
