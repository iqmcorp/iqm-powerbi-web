// Use this file to write queries to test your data connector
let
    result = IQM_Reports.Contents("US/Eastern", #datetimezone(2018, 1, 1, 0, 0, 0, 0, 0), #datetimezone(2022, 12, 31, 0, 0, 0, 0, 0))
in
    result