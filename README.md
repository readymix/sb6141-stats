# sb6141-stats
PowerShell Script to collect statistics from the Surfboard SB6141 Cable Modem.

The variables are echoed at the end, this is where you would pipe out the data and send to an InfluxDB for Grafana, Export to a CSV file, or any other place you'd like to collect and save the data.  Helpful when diagnosing issues with your cable modem or ISP's data signal.

Credit goes to sandersjds for the idea of indexing of the table data, and for the initial reference points.
https://github.com/sandersjds/prtg-sensors
