// Use this file to write queries to test your data connector
let
    result = IQM_Reports.Contents("US/Pacific", #datetimezone(2020, 7, 1, 0, 0, 0, -7, 0), #datetimezone(2021, 6, 30, 23, 59, 59, -7, 0))
in
    result