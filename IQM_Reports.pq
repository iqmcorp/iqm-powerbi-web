// This file contains your Data Connector logic
[Version = "1.0.0"]
section IQM_Reports;


/*
	Part 1: Constants
	OAuth constants, TIMEZONE_TABLE, schema tables, map of API column names to user-friendly column names.
*/
//OAuth2 constants
CLIENT_ID = "ZYDPLLBWSK3MVQJSIYHB1OR2JXCY0X2C5UJ2QAR2MAAIT5Q";
CLIENT_SECRET = "fNZiRPyz0PfWSqfLrRkdw1Ou";
AUTHORIZE_URI = "https://app.iqm.com/oauth/authorize";
REDIRECT_URI = "https://oauth.powerbi.com/views/oauthredirect.html";
TOKEN_URI = "https://app.iqm.com/oauth/token";
REFRESH_URI = "https://app.iqm.com/oauth/token";
WINDOW_HEIGHT = 600;
WINDOW_WIDTH = 800;

//Unix epoch constant for calculating startDate and endDate as timestamps.
UNIX_EPOCH = #datetimezone(1970, 1, 1, 0, 0, 0, 0, 0);

//Page size, for paging.
PAGE_SIZE = 50;     

//Table mapping timezone "label" strings (shown to the user in a dropdown menu) to timezone "value"s (ids to be passed to the API)
//Labels and values are copied from the IQM timezone API
TIMEZONE_TABLE = #table( {"value", "label"}, {
	{ "423", "US/Central" },
	{ "29", "US/Eastern" },
	{ "21", "US/Mountain" },
	{ "433", "US/Pacific" },
	{ "420", "US/Alaska" },
	{ "421", "US/Arizona" },
	{ "11", "UTC" },
	{ "118", "Africa/Abidjan" },
	{ "164", "Africa/Accra" },
	{ "149", "Africa/Addis Ababa" },
	{ "139", "Africa/Algiers" },
	{ "145", "Africa/Asmara" },
	{ "239", "Africa/Bamako" },
	{ "115", "Africa/Bangui" },
	{ "170", "Africa/Banjul" },
	{ "178", "Africa/Bissau" },
	{ "252", "Africa/Blantyre" },
	{ "116", "Africa/Brazzaville" },
	{ "56", "Africa/Bujumbura" },
	{ "143", "Africa/Cairo" },
	{ "230", "Africa/Casablanca" },
	{ "147", "Africa/Ceuta" },
	{ "171", "Africa/Conakry" },
	{ "339", "Africa/Dakar" },
	{ "363", "Africa/Dar es Salaam" },
	{ "135", "Africa/Djibouti" },
	{ "122", "Africa/Douala" },
	{ "144", "Africa/El Aaiun" },
	{ "337", "Africa/Freetown" },
	{ "81", "Africa/Gaborone" },
	{ "416", "Africa/Harare" },
	{ "414", "Africa/Johannesburg" },
	{ "342", "Africa/Juba" },
	{ "367", "Africa/Kampala" },
	{ "330", "Africa/Khartoum" },
	{ "326", "Africa/Kigali" },
	{ "113", "Africa/Kinshasa" },
	{ "271", "Africa/Lagos" },
	{ "158", "Africa/Libreville" },
	{ "351", "Africa/Lome" },
	{ "8", "Africa/Luanda" },
	{ "114", "Africa/Lubumbashi" },
	{ "415", "Africa/Lusaka" },
	{ "173", "Africa/Malabo" },
	{ "266", "Africa/Maputo" },
	{ "225", "Africa/Maseru" },
	{ "347", "Africa/Mbabane" },
	{ "340", "Africa/Mogadishu" },
	{ "224", "Africa/Monrovia" },
	{ "202", "Africa/Nairobi" },
	{ "349", "Africa/Ndjamena" },
	{ "269", "Africa/Niamey" },
	{ "247", "Africa/Nouakchott" },
	{ "53", "Africa/Ouagadougou" },
	{ "57", "Africa/Porto-Novo" },
	{ "343", "Africa/Sao Tome" },
	{ "229", "Africa/Tripoli" },
	{ "357", "Africa/Tunis" },
	{ "267", "Africa/Windhoek" },
	{ "398", "America/Adak" },
	{ "392", "America/Anchorage" },
	{ "5", "America/Anguilla" },
	{ "4", "America/Antigua" },
	{ "67", "America/Araguaina" },
	{ "19", "America/Argentina/Buenos Aires" },
	{ "24", "America/Argentina/Catamarca" },
	{ "20", "America/Argentina/Cordoba" },
	{ "22", "America/Argentina/Jujuy" },
	{ "253", "America/Argentina/La Rioja" },
	{ "27", "America/Argentina/Mendoza" },
	{ "418", "America/Argentina/Rio Gallegos" },
	{ "422", "America/Argentina/Salta" },
	{ "26", "America/Argentina/San Juan" },
	{ "28", "America/Argentina/San Luis" },
	{ "23", "America/Argentina/Tucuman" },
	{ "30", "America/Argentina/Ushuaia" },
	{ "46", "America/Aruba" },
	{ "300", "America/Asuncion" },
	{ "96", "America/Atikokan" },
	{ "69", "America/Bahia" },
	{ "263", "America/Bahia Banderas" },
	{ "50", "America/Barbados" },
	{ "64", "America/Belem" },
	{ "83", "America/Belize" },
	{ "89", "America/Blanc-Sablon" },
	{ "75", "America/Boa Vista" },
	{ "125", "America/Bogota" },
	{ "389", "America/Boise" },
	{ "103", "America/Cambridge Bay" },
	{ "71", "America/Campo Grande" },
	{ "254", "America/Cancun" },
	{ "405", "America/Caracas" },
	{ "162", "America/Cayenne" },
	{ "213", "America/Cayman" },
	{ "381", "America/Chicago" },
	{ "259", "America/Chihuahua" },
	{ "126", "America/Costa Rica" },
	{ "106", "America/Creston" },
	{ "72", "America/Cuiaba" },
	{ "129", "America/Curacao" },
	{ "167", "America/Danmarkshavn" },
	{ "111", "America/Dawson" },
	{ "107", "America/Dawson Creek" },
	{ "388", "America/Denver" },
	{ "372", "America/Detroit" },
	{ "137", "America/Dominica" },
	{ "289", "America/Edmonton" },
	{ "77", "America/Eirunepe" },
	{ "344", "America/El Salvador" },
	{ "65", "America/Fortaleza" },
	{ "108", "America/Fort Nelson" },
	{ "86", "America/Glace Bay" },
	{ "166", "America/Godthab" },
	{ "88", "America/Goose Bay" },
	{ "348", "America/Grand Turk" },
	{ "160", "America/Grenada" },
	{ "172", "America/Guadeloupe" },
	{ "176", "America/Guatemala" },
	{ "140", "America/Guayaquil" },
	{ "179", "America/Guyana" },
	{ "85", "America/Halifax" },
	{ "127", "America/Havana" },
	{ "261", "America/Hermosillo" },
	{ "375", "America/Indiana/Indianapolis" },
	{ "383", "America/Indiana/Knox" },
	{ "378", "America/Indiana/Marengo" },
	{ "379", "America/Indiana/Petersburg" },
	{ "382", "America/Indiana/Tell City" },
	{ "380", "America/Indiana/Vevay" },
	{ "376", "America/Indiana/Vincennes" },
	{ "377", "America/Indiana/Winamac" },
	{ "192", "America/Inuvik" },
	{ "93", "America/Iqaluit" },
	{ "199", "America/Jamaica" },
	{ "393", "America/Juneau" },
	{ "373", "America/Kentucky/Louisville" },
	{ "374", "America/Kentucky/Monticello" },
	{ "62", "America/Kralendijk" },
	/*{ "426", "America/La" },*/
	{ "61", "America/La Paz" },
	{ "282", "America/Lima" },
	{ "17", "America/Los Angeles" },
	{ "345", "America/Lower Princes" },
	{ "68", "America/Maceio" },
	{ "272", "America/Managua" },
	{ "76", "America/Manaus" },
	{ "234", "America/Marigot" },
	{ "246", "America/Martinique" },
	{ "257", "America/Matamoros" },
	{ "258", "America/Mazatlan" },
	{ "384", "America/Menominee" },
	{ "255", "America/Merida" },
	{ "395", "America/Metlakatla" },
	{ "25", "America/Mexico City" },
	{ "291", "America/Miquelon" },
	{ "87", "America/Moncton" },
	{ "256", "America/Monterrey" },
	{ "400", "America/Montevideo" },
	{ "248", "America/Montserrat" },
	{ "79", "America/Nassau" },
	{ "371", "America/New York" },
	{ "91", "America/Nipigon" },
	{ "397", "America/Nome" },
	{ "63", "America/Noronha" },
	{ "387", "America/North Dakota/Beulah" },
	{ "385", "America/North Dakota/Center" },
	{ "386", "America/North Dakota/New Salem" },
	{ "260", "America/Ojinaga" },
	{ "281", "America/Panama" },
	{ "94", "America/Pangnirtung" },
	{ "341", "America/Paramaribo" },
	{ "390", "America/Phoenix" },
	{ "183", "America/Port-au-Prince" },
	{ "74", "America/Porto Velho" },
	{ "360", "America/Port of Spain" },
	{ "293", "America/Puerto Rico" },
	{ "99", "America/Rainy River" },
	{ "97", "America/Rankin Inlet" },
	{ "66", "America/Recife" },
	{ "100", "America/Regina" },
	{ "95", "America/Resolute" },
	{ "78", "America/Rio Branco" },
	{ "73", "America/Santarem" },
	{ "120", "America/Santiago" },
	{ "138", "America/Santo Domingo" },
	{ "70", "America/Sao Paulo" },
	{ "168", "America/Scoresbysund" },
	{ "394", "America/Sitka" },
	{ "58", "America/St Barthelemy" },
	{ "84", "America/St Johns" },
	{ "209", "America/St Kitts" },
	{ "221", "America/St Lucia" },
	{ "407", "America/St Thomas" },
	{ "404", "America/St Vincent" },
	{ "101", "America/Swift Current" },
	{ "181", "America/Tegucigalpa" },
	{ "169", "America/Thule" },
	{ "92", "America/Thunder Bay" },
	{ "262", "America/Tijuana" },
	{ "90", "America/Toronto" },
	{ "406", "America/Tortola" },
	{ "109", "America/Vancouver" },
	{ "110", "America/Whitehorse" },
	{ "98", "America/Winnipeg" },
	{ "396", "America/Yakutat" },
	{ "104", "America/Yellowknife" },
	{ "14", "Antarctica/Casey" },
	{ "13", "Antarctica/Davis" },
	{ "16", "Antarctica/DumontDUrville" },
	{ "34", "Antarctica/Macquarie" },
	{ "419", "Antarctica/Mawson" },
	{ "9", "Antarctica/McMurdo" },
	{ "417", "Antarctica/Palmer" },
	{ "10", "Antarctica/Rothera" },
	{ "391", "Antarctica/Syowa" },
	{ "18", "Antarctica/Troll" },
	{ "15", "Antarctica/Vostok" },
	{ "335", "Arctic/Longyearbyen" },
	{ "412", "Asia/Aden" },
	{ "214", "Asia/Almaty" },
	{ "200", "Asia/Amman" },
	{ "325", "Asia/Anadyr" },
	{ "217", "Asia/Aqtau" },
	{ "216", "Asia/Aqtobe" },
	{ "356", "Asia/Ashgabat" },
	{ "194", "Asia/Baghdad" },
	{ "55", "Asia/Bahrain" },
	{ "48", "Asia/Baku" },
	{ "352", "Asia/Bangkok" },
	{ "220", "Asia/Beirut" },
	{ "203", "Asia/Bishkek" },
	{ "60", "Asia/Brunei" },
	{ "316", "Asia/Chita" },
	{ "243", "Asia/Choibalsan" },
	{ "430", "Asia/Chongqing" },
	{ "223", "Asia/Colombo" },
	{ "346", "Asia/Damascus" },
	{ "51", "Asia/Dhaka" },
	{ "355", "Asia/Dili" },
	{ "2", "Asia/Dubai" },
	{ "353", "Asia/Dushanbe" },
	{ "294", "Asia/Gaza" },
	{ "295", "Asia/Hebron" },
	{ "180", "Asia/Hong Kong" },
	{ "242", "Asia/Hovd" },
	{ "408", "Asia/Ho Chi Minh" },
	{ "315", "Asia/Irkutsk" },
	{ "185", "Asia/Jakarta" },
	{ "188", "Asia/Jayapura" },
	{ "190", "Asia/Jerusalem" },
	{ "3", "Asia/Kabul" },
	{ "324", "Asia/Kamchatka" },
	{ "102", "Asia/Karachi" },
	{ "275", "Asia/Kathmandu" },
	{ "429", "Asia/Katmandu" },
	{ "318", "Asia/Khandyga" },
	{ "105", "Asia/Kolkata" },
	{ "314", "Asia/Krasnoyarsk" },
	{ "264", "Asia/Kuala Lumpur" },
	{ "265", "Asia/Kuching" },
	{ "212", "Asia/Kuwait" },
	{ "244", "Asia/Macau" },
	{ "322", "Asia/Magadan" },
	{ "187", "Asia/Makassar" },
	{ "288", "Asia/Manila" },
	{ "280", "Asia/Muscat" },
	{ "131", "Asia/Nicosia" },
	{ "313", "Asia/Novokuznetsk" },
	{ "312", "Asia/Novosibirsk" },
	{ "311", "Asia/Omsk" },
	{ "218", "Asia/Oral" },
	{ "204", "Asia/Phnom Penh" },
	{ "186", "Asia/Pontianak" },
	{ "210", "Asia/Pyongyang" },
	{ "301", "Asia/Qatar" },
	{ "215", "Asia/Qyzylorda" },
	{ "240", "Asia/Rangoon" },
	{ "327", "Asia/Riyadh" },
	{ "320", "Asia/Sakhalin" },
	{ "401", "Asia/Samarkand" },
	{ "211", "Asia/Seoul" },
	{ "123", "Asia/Shanghai" },
	{ "332", "Asia/Singapore" },
	{ "323", "Asia/Srednekolymsk" },
	{ "362", "Asia/Taipei" },
	{ "402", "Asia/Tashkent" },
	{ "161", "Asia/Tbilisi" },
	{ "195", "Asia/Tehran" },
	{ "80", "Asia/Thimphu" },
	{ "201", "Asia/Tokyo" },
	{ "241", "Asia/Ulaanbaatar" },
	{ "431", "Asia/Ulan Bator" },
	{ "124", "Asia/Urumqi" },
	{ "321", "Asia/Ust-Nera" },
	{ "219", "Asia/Vientiane" },
	{ "319", "Asia/Vladivostok" },
	{ "317", "Asia/Yakutsk" },
	{ "310", "Asia/Yekaterinburg" },
	{ "7", "Asia/Yerevan" },
	{ "298", "Atlantic/Azores" },
	{ "59", "Atlantic/Bermuda" },
	{ "148", "Atlantic/Canary" },
	{ "128", "Atlantic/Cape Verde" },
	{ "156", "Atlantic/Faroe" },
	{ "297", "Atlantic/Madeira" },
	{ "196", "Atlantic/Reykjavik" },
	{ "175", "Atlantic/South Georgia" },
	{ "152", "Atlantic/Stanley" },
	{ "333", "Atlantic/St Helena" },
	{ "42", "Australia/Adelaide" },
	{ "40", "Australia/Brisbane" },
	{ "39", "Australia/Broken Hill" },
	{ "432", "Australia/Canberra" },
	{ "36", "Australia/Currie" },
	{ "43", "Australia/Darwin" },
	{ "45", "Australia/Eucla" },
	{ "35", "Australia/Hobart" },
	{ "41", "Australia/Lindeman" },
	{ "33", "Australia/Lord Howe" },
	{ "37", "Australia/Melbourne" },
	{ "44", "Australia/Perth" },
	{ "38", "Australia/Sydney" },
	{ "425", "Canada/Atlantic" },
	{ "427", "Canada/Newfoundland" },
	{ "424", "Canada/Saskatchewan" },
	{ "428", "Etc/Greenwich" },
	{ "273", "Europe/Amsterdam" },
	{ "1", "Europe/Andorra" },
	{ "174", "Europe/Athens" },
	{ "304", "Europe/Belgrade" },
	{ "133", "Europe/Berlin" },
	{ "336", "Europe/Bratislava" },
	{ "52", "Europe/Brussels" },
	{ "303", "Europe/Bucharest" },
	{ "184", "Europe/Budapest" },
	{ "134", "Europe/Busingen" },
	{ "232", "Europe/Chisinau" },
	{ "136", "Europe/Copenhagen" },
	{ "189", "Europe/Dublin" },
	{ "165", "Europe/Gibraltar" },
	{ "163", "Europe/Guernsey" },
	{ "150", "Europe/Helsinki" },
	{ "191", "Europe/Isle of Man" },
	{ "359", "Europe/Istanbul" },
	{ "198", "Europe/Jersey" },
	{ "305", "Europe/Kaliningrad" },
	{ "364", "Europe/Kiev" },
	{ "296", "Europe/Lisbon" },
	{ "334", "Europe/Ljubljana" },
	{ "159", "Europe/London" },
	{ "227", "Europe/Luxembourg" },
	{ "146", "Europe/Madrid" },
	{ "249", "Europe/Malta" },
	{ "47", "Europe/Mariehamn" },
	{ "82", "Europe/Minsk" },
	{ "231", "Europe/Monaco" },
	{ "306", "Europe/Moscow" },
	{ "274", "Europe/Oslo" },
	{ "157", "Europe/Paris" },
	{ "233", "Europe/Podgorica" },
	{ "132", "Europe/Prague" },
	{ "228", "Europe/Riga" },
	{ "197", "Europe/Rome" },
	{ "309", "Europe/Samara" },
	{ "338", "Europe/San Marino" },
	{ "49", "Europe/Sarajevo" },
	{ "307", "Europe/Simferopol" },
	{ "238", "Europe/Skopje" },
	{ "54", "Europe/Sofia" },
	{ "331", "Europe/Stockholm" },
	{ "142", "Europe/Tallinn" },
	{ "6", "Europe/Tirane" },
	{ "365", "Europe/Uzhgorod" },
	{ "222", "Europe/Vaduz" },
	{ "403", "Europe/Vatican" },
	{ "32", "Europe/Vienna" },
	{ "226", "Europe/Vilnius" },
	{ "308", "Europe/Volgograd" },
	{ "290", "Europe/Warsaw" },
	{ "182", "Europe/Zagreb" },
	{ "366", "Europe/Zaporozhye" },
	{ "117", "Europe/Zurich" },
	{ "235", "Indian/Antananarivo" },
	{ "193", "Indian/Chagos" },
	{ "130", "Indian/Christmas" },
	{ "112", "Indian/Cocos" },
	{ "208", "Indian/Comoro" },
	{ "350", "Indian/Kerguelen" },
	{ "329", "Indian/Mahe" },
	{ "251", "Indian/Maldives" },
	{ "250", "Indian/Mauritius" },
	{ "413", "Indian/Mayotte" },
	{ "302", "Indian/Reunion" },
	{ "411", "Pacific/Apia" },
	{ "278", "Pacific/Auckland" },
	{ "287", "Pacific/Bougainville" },
	{ "279", "Pacific/Chatham" },
	{ "153", "Pacific/Chuuk" },
	{ "121", "Pacific/Easter" },
	{ "409", "Pacific/Efate" },
	{ "206", "Pacific/Enderbury" },
	{ "354", "Pacific/Fakaofo" },
	{ "151", "Pacific/Fiji" },
	{ "361", "Pacific/Funafuti" },
	{ "141", "Pacific/Galapagos" },
	{ "285", "Pacific/Gambier" },
	{ "328", "Pacific/Guadalcanal" },
	{ "177", "Pacific/Guam" },
	{ "399", "Pacific/Honolulu" },
	{ "368", "Pacific/Johnston" },
	{ "207", "Pacific/Kiritimati" },
	{ "155", "Pacific/Kosrae" },
	{ "237", "Pacific/Kwajalein" },
	{ "236", "Pacific/Majuro" },
	{ "284", "Pacific/Marquesas" },
	{ "369", "Pacific/Midway" },
	{ "276", "Pacific/Nauru" },
	{ "277", "Pacific/Niue" },
	{ "270", "Pacific/Norfolk" },
	{ "268", "Pacific/Noumea" },
	{ "31", "Pacific/Pago Pago" },
	{ "299", "Pacific/Palau" },
	{ "292", "Pacific/Pitcairn" },
	{ "154", "Pacific/Pohnpei" },
	{ "286", "Pacific/Port Moresby" },
	{ "119", "Pacific/Rarotonga" },
	{ "245", "Pacific/Saipan" },
	{ "12", "Pacific/Samoa" },
	{ "283", "Pacific/Tahiti" },
	{ "205", "Pacific/Tarawa" },
	{ "358", "Pacific/Tongatapu" },
	{ "370", "Pacific/Wake" },
	{ "410", "Pacific/Wallis" }
});


//A table of dimensions to group ad-serving data by. "label" and "value" should be the same as those passed to the /serving/result API endpoint.
DIMENSION = #table( {"value", "label"}, {
	{"campaign", "Campaigns"},
	{"creative", "Creatives"}
});



//The SCHEMA_TABLE_AGGREGATED table is used as a "schema" for the table that the API results (from /serving/result, with request_type = "total") will be placed in. 
//It defines the order of columns and the M data type of each column. 
//The ad-serving data from the /serving/result API endpoint will be placed into a table formatted according to the SCHEMA_TABLE.
SCHEMA_CAMPAIGN_AGGREGATED = #table({"Name", "Type", "Position", "Description"}, {
    {"campaignId", type text, 0, "Unique system-generated numerical ID assigned to each campaign"},
    {"campaignName", type text, 1, ""},
    {"startTime", type nullable date, 2, "Campaign start date."},
    {"endTime", type nullable date, 3, "Campaign end date."},
    {"maxBid", type number, 4, "Amount up to which you allow IQM to bid."},
    {"budgetDay", type number, 5, "Amount up to which you allow IQM to spend on average each day."},
    {"budgetTotal", type number, 6, "Amount up to which you allow IQM to spend."},
    {"audioVideoViewed", type number, 7, "Total duration of audio/video ads viewed."},
    {"startCount", type number, 8, "Number of video ads that start to play."},
    {"firstCount", type number, 9, "Number of video ads that play through 25% of their duration."},
    {"midCount", type number, 10, "Number of video ads that play through 50% of their duration."},
    {"thirdCount", type number, 11, "Number of video ads that play through 75% of their duration."},
    {"completeCount", type number, 12, "Number of video ads that play through to completion."},
    {"impressions", type number, 13, "Number of times ad is displayed on someone's screen."},
    {"clicks", type number, 14, "Number of times someone clicks your ad."},
    {"mediaSpent", type number, 15, "Amount spent to win impressions."},
    {"spent", type number, 16, "Sum of the Media Spent and Data Spent."},
    {"dataCost", type number, 17, "Amount spent to serve impressions to audiences you matched or purchased."},
    {"winRate", type number, 18, "Percentage of impressions won per bids made."},
    {"CTR", type number, 19, "Click-through rate is the percentage of clicks received per impressions served."},
    {"VCR", type number, 20, "Video completion rate is the percentage of video ads that play through to completion."},
    {"eCPC", type number, 21, "Effective cost per click is the amount spent divided by the number of clicks."},
    {"eCPM", type number, 22, "Effective cost per mile is the amount you pay per one thousand impressions."},
    {"eCPCV", type number, 23, "Cost per completed view is the amount spent divided by the number of video ads that play through to completion."}
});


//SCHEMA_TABLE_DAILY is used as a "schema" for the table that the API results (from /serving/result, with request_type = "total") will be placed in. 
//It is the SCHEMA_TABLE_AGGREGATED table, with a row inserted at the beginning corresponding to the "Date" column in the API result table.
SCHEMA_CAMPAIGN_DAILY = #table( {"Name", "Type", "Position", "Description"}, List.Union({ {{"date", type nullable date, 0, "Date"}}, Table.ToRows(Table.TransformColumns(SCHEMA_CAMPAIGN_AGGREGATED, {"Position", (pos) => if (pos <> null) then pos + 1 else null})) }));


//Used as the schema for the /serving/results result table grouped by the creative dimension and aggregated
SCHEMA_CREATIVE_AGGREGATED = #table({"Name", "Type", "Position"}, {
	{"creativeId", type number, 0},
	{"creativeName", type text, 1},
	{"audioVideoViewed", type number, 2},
	{"impressions", type number, 3},
	{"clicks", type number, 4},
	{"mediaSpent", type number, 5},
	{"spent", type number, 6},
	{"dataCost", type number, 7},
	{"winRate", type number, 8},
	{"CTR", type number, 9},
	{"VCR", type number, 10},
	{"eCPC", type number, 11},
	{"eCPM", type number, 12},
	{"eCPCV", type number, 13},
	{"startCount", type number, 14},
    {"firstCount", type number, 15},
    {"midCount", type number, 16},
    {"thirdCount", type number, 17},
    {"completeCount", type number, 18}
});


//Used as the schema for the /serving/results result table grouped by the creative dimension
SCHEMA_CREATIVE_DAILY = #table({"Name", "Type", "Position"}, {
	{"date", type nullable date, 0},
	{"creativeId", type number, 1},
	{"creativeName", type text, 2},
	{"audioVideoViewed", type number, 3},
	{"impressions", type number, 4},
	{"clicks", type number, 5},
	{"mediaSpent", type number, 6},
	{"spent", type number, 7},
	{"dataCost", type number, 8},
	{"winRate", type number, 9},
	{"CTR", type number, 10},
	{"VCR", type number, 11},
	{"eCPC", type number, 12},
	{"eCPM", type number, 13},
	{"eCPCV", type number, 14},
	{"startCount", type number, 15},
    {"firstCount", type number, 16},
    {"midCount", type number, 17},
    {"thirdCount", type number, 18},
    {"completeCount", type number, 19}
});


//Schema for /serving/results result table containing aggregated data grouped by campaigns by creatives and aggregated
SCHEMA_CAMPAIGN_CREATIVE_AGGREGATED = #table({"Name", "Type", "Position"}, {
	{"campaignId", type text, 0},
	{"creativeId", type number, 1},
	{"campaignName", type text, 2},
	{"creativeName", type text, 3},
	{"startTime", type nullable date, 4},
    {"endTime", type nullable date, 5},
    {"maxBid", type number, 6},
    {"budgetDay", type number, 7},
    {"budgetTotal", type number, 8},
    {"impressions", type number, 9},
	{"clicks", type number, 10},
	{"mediaSpent", type number, 11},
	{"spent", type number, 12},
	{"dataCost", type number, 13},
	{"winRate", type number, 14},
	{"CTR", type number, 15},
	{"VCR", type number, 16},
	{"eCPC", type number, 17},
	{"eCPM", type number, 18},
	{"eCPCV", type number, 19},
	{"startCount", type number, 20},
    {"firstCount", type number, 21},
    {"midCount", type number, 22},
    {"thirdCount", type number, 23},
    {"completeCount", type number, 24}
});


//Schema for /serving/results result table containing data grouped by campaigns by creatives, daily
SCHEMA_CAMPAIGN_CREATIVE_DAILY = #table({"Name", "Type", "Position"}, {
	{"date", type nullable date, 0},
	{"campaignId", type text, 1},
	{"creativeId", type number, 2},
	{"campaignName", type text, 3},
	{"creativeName", type text, 4},
	{"startTime", type nullable date, 5},
    {"endTime", type nullable date, 6},
    {"maxBid", type number, 7},
    {"budgetDay", type number, 8},
    {"budgetTotal", type number, 9},
    {"impressions", type number, 10},
	{"clicks", type number, 11},
	{"mediaSpent", type number, 12},
	{"spent", type number, 13},
	{"dataCost", type number, 14},
	{"winRate", type number, 15},
	{"CTR", type number, 16},
	{"VCR", type number, 17},
	{"eCPC", type number, 18},
	{"eCPM", type number, 19},
	{"eCPCV", type number, 20},
	{"startCount", type number, 21},
    {"firstCount", type number, 22},
    {"midCount", type number, 23},
    {"thirdCount", type number, 24},
    {"completeCount", type number, 25}
});




/*
	COLUMN_NAMES_MAP_API_TO_UI maps the property names for the data returned in the response from the API /serving/result endpoint
	to "pretty" user-firendly names that will be used as column names and displayed to the user.

	For example, the API returns objects with a property of "maxBid". The data associated with this property will be placed in a column
	named "Max Bid ($)".
*/
COLUMN_NAMES_MAP_API_TO_UI = [
	creativeId = "Creative ID",
	creativeName = "Creative Name",
	campaignId = "Campaign ID",
	campaignName = "Campaign Name",
	date = "Date",
	startTime = "Start Date",
	endTime = "End Date",
	campaignTimezone = "Campaign Timezone",
	maxBid = "Max Bid ($)",
	budgetDay = "Daily Budget ($)",
	budgetTotal = "Total Budget ($)",
	audioVideoViewed = "Seconds AudioVideo Viewed",
	startCount = "Video Start",
	firstCount = "Video 25%",
	midCount = "Video 50%",
	thirdCount = "Video 75%",
	completeCount = "Video 100%",
	impressions = "Impressions",
	clicks = "Clicks",
	mediaSpent = "Media Spent ($)",
	spent = "Total Spent ($)",
	dataCost = "Data Cost ($)",
	winRate = "Win Rate (%)",
	CTR = "CTR (%)",
	VCR = "VCR (%)",
	eCPC = "eCPC ($)",
	eCPM = "eCPM ($)",
	eCPCV = "CPCV ($)"
];



/*
	Part 2: Functions to retrieve and transform API results
*/

/*
	getServingResultsPage retrieves a single page of data from the /serving/result IQM API endpoint and returns the data as an M table.
	If there is no more data to be retrieved then the function returns null.
	Parameters:
		timezoneId: The ID of a timezone (as from the IQM timezone API, or in the TIMEZONE_TABLE)
		timezoneString: The string representing the same timezone as the timezoneId; example: "Europe/London"
		startDateTimestamp: A Unix timestamp in milliseconds representing the start of the time interval to retrieve report data for.
		endDateTimestamp: A Unix timestamp in milliseconds representing the end of the time interval to retrieve report data for.
		dimension: A string corresponding to the dimension.filter.label body parameter (i.e. "Campaigns", "Creatives", etc)
		secondDimension: A string corresponding to the secondDimension.filter.label body parameter (i.e. "Creatives", etc)
		pageNum: The page of results to retrieve. Page size is determined by the global PAGE_SIZE constant.
		aggregation: Must be "daily" or "total". Tells the API how to aggregate the data; is passed to the API as the request_type body parameter
*/
getServingResultsPage = (timezoneId as number, timezoneString as text, startDateTimestamp as number, endDateTimestamp as number, dimension as text, secondDimension as nullable text, aggregation as text, pageNum as number)  as nullable table =>
    let
        requestUrl = "https://app.iqm.com/api/v2/rb/serving/result",

		//This record represents the request body.
		bodyRecord = [								
            total_agg = false,
            page_number = pageNum,
            total_count = PAGE_SIZE,
            request_type = aggregation,
            dateRange = [
                startDate = startDateTimestamp,
                endDate = endDateTimestamp
            ],
            timezone = [
				value = timezoneString,
				id = timezoneId
            ],
            dimension = [
                filter = [
                    value = Record.Field(Table.ToRecords(Table.SelectRows(DIMENSION, each [label] = dimension)){0}, "value"),
                    label = dimension 
                ]
            ],
            search_field = "",
            filters = [
                campaign_status = "running",
                creative_type_ids = ""
            ],
            sort_by = if (aggregation = "daily") then "date" else "impressions",
            sort_type = "desc",
            status = "running"
        ], //body record

		secondDimensionRecord = [
			filter = [
				value = if (secondDimension <> null) then Record.Field(Table.ToRecords(Table.SelectRows(DIMENSION, each [label] = secondDimension)){0}, "value") else null,
				label = secondDimension 
			]
		],

        body = Json.FromValue(if (secondDimension = null) then bodyRecord else Record.AddField(bodyRecord, "secondDimension", secondDimensionRecord)),   

		//Request headers.
        headers = [             
            #"Content-Type" = "application/json",
            #"Accept" = "application/json"
            //M engine automatically adds the Authorization header.
        ],

		//Send HTTP request to API endpoint
		//apiResponse is a record/object containing the "total" object and "data" list of objects (see IQM API)
        apiResponse = Json.Document(Web.Contents(requestUrl, [Headers = headers, Content = body])),         
		
        responseTable = if (List.Count(apiResponse[data]) = 0)  
			//If the "data" list is empty, we've reached the end of the paginated data. So, return null.
            then
                null 
			//If "data" list is not empty, create a table from the objects within the list and return that table.
			//Include metadata: "pageNum" tells which page number this current page/table of results corresponds to. 
			//pageNum is equal to the page_number in the request body and is used in ContentsFunction (in the nested function getNextPage) to calculate the next page's number.
            else 
				Table.FromRecords(apiResponse[data]) meta [pageNum = pageNum] 
    in
        responseTable;


/*
	The GetServingResultsTable function repeatedly calls the GetServingResultsPage function in order to retrieve all pages of data from the API.
	It then gathers the paginated data into a single M table, which it returns. 

	GetServingResultsTable's parameters are passed as-is to the corresponding parameters of the GetServingResultsPage function, where they are inserted
	into the body of the API request to /serving/result.
*/
GetServingResultsTable = (timezoneId as number, timezoneString as text, startDateTimestamp as number, endDateTimestamp as number, dimension as text, secondDimension as nullable text, aggregation as text) as nullable table =>
	let
		/*
			Nested Function: getNextPage(lastPage as table) as nullable table
			getNextPage is a function used for the paging logic. It retrieves a page of results (represented as an M table) by calling getServingResultsPage.
			Parameters:
				prevPage:	A nullable table which represents the previous page of API results (null if no pages have been fetched yet/it is the first time the getNextPage function has been called).
							Based on the prevPage argument, getNextPage calculates the next page to be fetched, requests it from the API, converts the API response to a table, and returns that table.
							If no more data can be fetched from the API, getNextPage returns null.
			getNextPage is passed as a parameter to the helper function Table.GenerateByPage, which repeatedly calls getNextPage() and collates all the pages/tables returned from getNextPage() into a single M table.
		*/     
        getNextPage = (prevPage as nullable table) as nullable table =>
            let
                nextPage = if (prevPage = null)
                    then
                        getServingResultsPage(timezoneId, timezoneString, startDateTimestamp, endDateTimestamp, dimension, secondDimension, aggregation, 1)    
                    else
                        getServingResultsPage(timezoneId, timezoneString, startDateTimestamp, endDateTimestamp, dimension, secondDimension, aggregation, Value.Metadata(prevPage)[pageNum] + 1)     
            in
                nextPage,

		/*
			The nested transformColumns function applies the required processing to the values in certain columns of the table returned from
			Table.GenerateByPage. It converts the audioVideoViewed column to duration values, and startTime and endTime columns to date values.
		*/
		transformColumns = (inputTable as table) as table =>
			let
				withStartTimeAsDate = if (dimension = "Campaigns") then Table.TransformColumns(inputTable, {"startTime", TimestampToDate}) else inputTable,
				withEndTimeAsDate = if (dimension = "Campaigns") then Table.TransformColumns(withStartTimeAsDate, {"endTime", TimestampToDate}) else withStartTimeAsDate,
				withDateAsDate = Table.TransformColumns(withEndTimeAsDate, {"date", (value) => if (value <> null) then Date.FromText(value) else null}),
				withCtrAsPercentage = Table.TransformColumns(withDateAsDate, {"CTR", (value) => if (value <> null) then value/100 else null}),
				withVcrAsPercentage = Table.TransformColumns(withCtrAsPercentage, {"VCR", (value) => if (value <> null) then value/100 else null}),
				withWinRateAsPercentage = Table.TransformColumns(withVcrAsPercentage, {"winRate", (value) => if (value <> null) then value/100 else null})
			in 
				withWinRateAsPercentage,
		
		//One entry in this record for each aggregation+group_by+second_group_by combination
		schemas = [
			totalCampaigns = SCHEMA_CAMPAIGN_AGGREGATED,
			dailyCampaigns = SCHEMA_CAMPAIGN_DAILY,
			totalCreatives = SCHEMA_CREATIVE_AGGREGATED,
			dailyCreatives = SCHEMA_CREATIVE_DAILY,
			totalCampaignsCreatives = SCHEMA_CAMPAIGN_CREATIVE_AGGREGATED,
			dailyCampaignsCreatives = SCHEMA_CAMPAIGN_CREATIVE_DAILY
		],
		schemaIndex = aggregation & dimension & (if (secondDimension <> null) then secondDimension else ""),

		//Get full table of API results, transform values in table to those usable by Power BI as needed, change column names to reflect IQM Reports interface, and enforce the schema defined in SCHEMA_TABLE
        resultTable = Table.GenerateByPage(getNextPage),
		resultTableValuesConverted = transformColumns(resultTable),
        resultTableSchemaEnforced = SchemaTransformTable(resultTableValuesConverted, Record.Field(schemas, schemaIndex), EnforceSchema.Strict),
		resultTableWithColumnsNamed = Table.TransformColumnNames(resultTableSchemaEnforced, (name) => Record.Field(COLUMN_NAMES_MAP_API_TO_UI, name))
	in
		resultTableWithColumnsNamed;
		



/*
	ContentsFunction receives as arguments the values input by the user when the user configures the connector in Power BI Desktop.

	It converts those raw parameters into values and types expected by the /serving/result IQM API endpoint and
	passes those converted values to GetServingResulsTable, which returns the ad-serving report data from the API as M tables.
	ContentsFunction calls GetServingResultsTable twice in order to get both a table of aggregated report data and a table of daily report data.

	Finally, ContentsFunction creates and returns a user-friendly navigation table containing the two aforementioned tables. This allows the Power BI user
	to import both or either of these tables into their Power BI Desktop report.

	Parameters are values input by the user when the user selects the IQM Reports custom connector in Power BI desktop.
	Parameters:
		timezoneLabel: A timezone label string (as from TIMEZONE_TABLE or the IQM API)
		startDate: The start of the time interval to gather ad-serving report data for.
		endDate: The end of the time interval to gather ad-serving report data for.
		dimension: The 'group by' dimension to group ad-serving data by. Should be a value that can be passed as a dimension.filter.label body parameter to the /serving/result API endpoint
		secondDimension: The second 'group by' dimension to group ad-serving data by. Should be a value that can be passed as a secondDimension.filter.label body parameter to the /serving/result API endpoint
*/
ContentsFunction = (timezoneLabel as text, startDate as datetimezone, endDate as datetimezone, dimension as text, optional secondDimension as text) as nullable table =>
    let
		output = if (dimension = secondDimension)	//Check to make sure the user didn't put the same dimension for both 'dimension' and 'secondDimension'
			then
				error Error.Record("Invalid Input", "Input Validation Failed: 'Group By' value must be distinct from 'Second Group By' value.")
			else
				let
					//Transform user inputs--timezoneLabel, startDate, endDate--into formats/values usable by the API
		
					//Convert timezoneLabel (text) into a numerical timezone ID that can be passed to the IQM API:
					//First, get the row in TIMEZONE_TABLE with the specified timezoneLabel
					timezoneIdTest = Table.SelectRows(TIMEZONE_TABLE, each [label] = timezoneLabel),	//timezoneIdTest should be a single-row table
					numRows = Table.RowCount(timezoneIdTest),	

					//Test to make sure the specified timezone label was found in the TIMEZONE_TABLE; if not, default to id=11 (UTC)
					timezoneId = if (numRows < 1)
						then
							11
						else
							Number.FromText(Table.Column(timezoneIdTest, "value"){0}),

					//Convert startDate and endDate from datetimezones to Unix timestamps (milliseconds)
					startDateDuration = startDate - UNIX_EPOCH,			
					endDateDuration = endDate - UNIX_EPOCH,
					startDateTimestamp = Duration.TotalSeconds(startDateDuration) * 1000,   
					endDateTimestamp = Duration.TotalSeconds(endDateDuration) * 1000,

					//Get the API /serving/results data as M tables.
					adServingReportAggregated = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, dimension, secondDimension, "total"),
					adServingReportDaily = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, dimension, secondDimension, "daily"),
					/*
					aggregatedCampaign = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, "campaign", null, "total"),
					dailyCampaign = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, "campaign", null, "daily"),
					aggregatedCreative = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, "creative", null, "total"),
					dailyCreative = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, "creative", null, "daily"),
					aggregatedCampaignByCreative = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, "campaign", "creative", "total"),
					dailyCampaignByCreative = GetServingResultsTable(timezoneId, timezoneLabel, startDateTimestamp, endDateTimestamp, "campaign", "creative", "daily"),
					*/


					//Insert the tables into a navigation table and return the navigation table.
					navTableFxnParam = #table(
						{"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"}, {
						{dimension & (if (secondDimension <> null) then " by " & secondDimension else "") & " Aggregated", "AdServingReportAggregated", adServingReportAggregated, "Table", "Table", true},
						{dimension & (if (secondDimension <> null) then " by " & secondDimension else "") & " Daily", "AdServingReportDaily", adServingReportDaily, "Table", "Table", true}
						/*
						{"Aggregated Ad Serving Report by Campaign", "AggregatedCampaign", aggregatedCampaign, "Table", "Table", true},
						{"Daily Ad Serving Report by Campaign", "DailyCampaign", dailyCampaign, "Table", "Table", true},
						{"Aggregated Ad Serving Report by Creative", "AggregatedCreative", aggregatedCreative, "Table", "Table", true},
						{"Daily Ad Serving Report by Creative", "DailyCreative", dailyCreative, "Table", "Table", true},
						{"Aggregated Ad Serving Report by Campaign and Creative", "AggregatedCampaignCreative", aggregatedCampaignByCreative, "Table", "Table", true},
						{"Daily Ad Serving Report by Campaign and Creative", "DailyCampaignCreative", dailyCampaignByCreative, "Table", "Table", true}
						*/
					}),
					navTable = Table.ToNavigationTable(navTableFxnParam, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
				in
					navTable
	in
		output;




/*
	Part 3: Connector definition
*/

//Define the type for the IQM_Reports.Contents function, including the "documentation"/helptext that will be shown to the user
ContentsFunctionType = type function (
	timezoneLabel as (type text meta [
		Documentation.FieldCaption = "Timezone",
		Documentation.AllowedValues = Table.Column(TIMEZONE_TABLE, "label"),
		Formatting.IsMultiLine = false,
		Formatting.IsCode = false
	]),
	startDate as (type datetimezone meta [
		Documentation.FieldCaption = "Date Interval Start",
		Documentation.FieldDescription = "Start of the timeframe for the ad-serving data to include in the report.",
		Formatting.IsMultiLine = false,
		Formatting.IsCode = false
	]),
	endDate as (type datetimezone meta [
		Documentation.FieldCaption = "Date Interval End",
		Documentation.FieldDescription = "End of the timeframe for the ad-serving data to include in the report.",
		Formatting.IsMultiLine = false,
		Formatting.IsCode = false
	]),
	dimension as (type text meta [
		Documentation.FieldCaption = "Group By",
		Documentation.FieldDescription = "Select the dimension of advertising data to group by.",
		Documentation.AllowedValues = Table.Column(DIMENSION, "label"),
		Formatting.IsMultiLine = false,
		Formatting.IsCode = false
	]),
	optional secondDimension as (type text meta [
		Documentation.FieldCaption = "Second Group By",
		Documentation.FieldDescription = "Select an optional second dimension of advertising data to group by. Must select a different value from the Group By dropdown.",
		Documentation.AllowedValues = {"Creatives"},
		Formatting.IsMultiLine = false,
		Formatting.IsCode = false
	]))
	as table meta [
		Documentation.Name = "IQM Reports",
		Documentation.LongDescription = "Get your IQM campaigns reporting data. Retrieves aggregated ad-serving report data for your ad campaigns."
	];


//Definitions for the connector: IQM_Reports.Contents is the connector's data source function. It is defined above as ContentsFunction.
[DataSource.Kind="IQM_Reports", Publish="IQM_Reports.Publish"]
shared IQM_Reports.Contents = Value.ReplaceType(ContentsFunction, ContentsFunctionType);

 
// Data Source Kind description
IQM_Reports = [
    TestConnection = (dataSourcePath) => 
		let
			json = Json.Document(dataSourcePath),
			timezoneLabel = json[timezoneLabel],
			startDate = json[startDate],
			endDate = json[endDate]
		in
			{"IQM_Reports.Contents", timezoneLabel, startDate, endDate},
    Authentication = [
        OAuth = [
            StartLogin = StartLogin,
            FinishLogin = FinishLogin
            //Refresh = Refresh
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
// Allows the connector to appear in the "Get Data" dialog of the Power BI Desktop app
IQM_Reports.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    SourceImage = IQM_Reports.Icons,
    SourceTypeImage = IQM_Reports.Icons
];

//Icons for the connector are defined here.
IQM_Reports.Icons = [
    Icon16 = { Extension.Contents("IQM_Reports_16.png"), Extension.Contents("IQM_Reports_20.png"), Extension.Contents("IQM_Reports_24.png"), Extension.Contents("IQM_Reports_32.png") },
    Icon32 = { Extension.Contents("IQM_Reports_32.png"), Extension.Contents("IQM_Reports_40.png"), Extension.Contents("IQM_Reports_48.png"), Extension.Contents("IQM_Reports_64.png") }
];




/*
	Part 4: Authentication with OAuth2
*/

/*
    StartLogin is the function used to initiate the OAuth 2 login flow: it must return a record of the form:
    [
        LoginUri = get_authorization_code_url,
        CallbackUri = redirect_uri,
        WindowHeight = window_height_for_login_window,
        WindowWidth = window_width_for_login_window,
        Context = optional_value_passed_to_FinishLogin
    ]

	Parameters:
		resourceUrl: Not used. The URL of the resource to be retrieved. (Some REST APIs require this for processing OAuth2 flows)
		state: State information generated by the M engine. Not used.
		display: Used by some APIs/OAuth2 flows to display info to the user. Not used.
*/
StartLogin = (resourceUrl, state, display) =>
    let
        queryParameters =   [
            client_id = CLIENT_ID,
            client_secret = CLIENT_SECRET,
            response_type = "code",
            scope = "read_user_info",
            redirect_uri = REDIRECT_URI
        ],
        authorizationCodeUrl = AUTHORIZE_URI & "?" & Uri.BuildQueryString(queryParameters)
    in
        [
            LoginUri = authorizationCodeUrl,
            CallbackUri = REDIRECT_URI,
            WindowHeight = WINDOW_HEIGHT,
            WindowWidth = WINDOW_WIDTH,
            Context = null
        ];


/*
    FinishLogin is called after StartLogin, when the response containing the authorization code is received from IQM.
    FinishLogin calls the Get Access Token https://app.iqm.com/oauth/token API method if IQM sent an authorization code.
    Parameters:
        context: From the record returned from StartLogin
        callbackUri: The URI containing the authorization code sent from IQM
        state: State info that was specified in the call to StartLogin (see StartLogin parameters.)
*/
FinishLogin = (context, callbackUri, state) =>
    let
        uriParts = Uri.Parts(callbackUri),      //Uri.Parts returns the parts of the URI parameter as a record; Host, Scheme, Path, Query, etc
        queryStringRecord = uriParts[Query],    //[Query] is a record of URL query parameters.
        authorizationCode = if (Record.HasFields(queryStringRecord, "code"))
            then 
                queryStringRecord[code]
            else
                error Error.Record("AuthenticationError", "Authorization code not received.", "Authorization code not received. Please check your login credentials and retry.")
    in
        //Now, request Access Token and Refresh Token from "Get Access Token" endpoint
        GetToken(authorizationCode, "authorization_code", TOKEN_URI);  //Exchange auth code for access token.


/*
	Refresh is called when the access_token expires and the connector must exchange the refresh_token for a new access_token.
	Parameters:
		resourceUrl: Not used. The URL of the resource to be retrieved. (Some REST APIs require this for processing OAuth2 flows)
		refresh_token: The refresh token to be exchanged for a new access token.
*/
Refresh = (resourceUrl, refresh_token) =>
    let 
        result = GetToken(refresh_token, "refresh_token", REFRESH_URI)
    in
        result;


/*
	GetToken is a helper function that exchanges a code (authorization code or refresh token) for an access token by calling the appropriate
	IQM API endpoint. This function returns an M record containing, at the least, an access_token and refresh_token.
	If an access token and refresh token cannot be retrieved from the IQM API, an error is thrown

	Parameters:
		code: Authorization code or refresh token
		grant_type: "authorization_code" or "refresh_token"
		requestUrl: The URL in the IQM API to send the request to in order to exchange the auth code or refresh token for an access token
*/
GetToken = (code, grantType, requestUrl) =>
    let
        body = if (grantType = "authorization_code")
            then
                Text.ToBinary(Uri.BuildQueryString([    //Body must be urlencoded, so use Uri.BuildQueryString to encode as URL query parameters format
                    code = code,
                    grant_type = grantType,
                    redirect_uri = REDIRECT_URI,
                    scope = "read_user_info",
                    client_id = CLIENT_ID,
                    client_secret = CLIENT_SECRET
                ]))
            else
                Text.ToBinary(Uri.BuildQueryString([
                    refresh_token = code,
                    grant_type = grantType,
                    redirect_uri = REDIRECT_URI,
                    scope = "read_user_info",
                    client_id = CLIENT_ID,
                    client_secret = CLIENT_SECRET
                ])),
        clientIdSecret = CLIENT_ID  & ":" & CLIENT_SECRET,
        clientIdSecretBin = Text.ToBinary(clientIdSecret),
        clientIdSecretBin64 = Binary.ToText(clientIdSecretBin, BinaryEncoding.Base64),
        headers = [
            #"Accept" = "application/json",
            #"Content-Type" = "application/x-www-form-urlencoded",
            #"Authorization" = "Basic " & clientIdSecretBin64
        ],
        response = Web.Contents(requestUrl, [Headers = headers, Content = body]),
        responseBody = Json.Document(response),    //Convert JSON response to M record.
        result = if (Record.HasFields(responseBody, {"access_token", "refresh_token"}))
            then
                responseBody
            else
                error Error.Record("AuthenticationError", "Failed to exchange authorization code/refresh token for access token. Please try again.", "Failed to exchange authorization code/refresh token for access token. Please try again.")
    in
        result;     //Contains access_token and refresh_token




/*
	Part 5: Miscellaneous Helper Functions
*/
/*
	TimestampToDate converts a Unix timestamp (seconds) to a value of type "date".
	The date value is the local date with respect to the user's system.
*/
TimestampToDate = (timestamp as nullable number) as nullable date =>
	let
		asDuration = if (timestamp <> null) then #duration(0, 0, 0, timestamp) else null,
		asDatetimezone = if (timestamp <> null) then UNIX_EPOCH + asDuration else null,
		asDate = if (timestamp <> null) then Date.From(asDatetimezone) else null
	in
		asDate;



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    The following functions Table.GenerateByPage and SchemaTransformTable are "helper functions" defined in the Power Query custom connector 
    documentation (https://docs.microsoft.com/en-us/power-query/helperfunctions).

    According to the documentation:
    "These functions may eventually be moved to the official M library, but for now can be copied into your extension file code."

    As per the recommendation in the documentation, these function definitions are copied+pasted here.
*/
/*
    Table.GenerateByPage collects the paginated results from the API and collates them into a single long table.

    The parameter getNextPage is a function that takes a nullable table as an argument. 
    This argument represents the previous page of API results (null if no pages have been fetched yet/it is the first time the getNextPage function has been called).
    Based on the table argument, getNextPage calculates the next page to be fetched, requests it from the API, converts the API response to a table, and returns that table.
    If no more data can be fetched from the API, getNextPage returns null.
*/
Table.GenerateByPage = (getNextPage as function) as table =>
    let        
        listOfPages = List.Generate(
            () => getNextPage(null),            // get the first page of data
            (lastPage) => lastPage <> null,     // stop when the function returns null
            (lastPage) => getNextPage(lastPage) // pass the previous page to the next function call
        ),
        // concatenate the pages together
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        // if we didn't get back any pages of data, return an empty table
        // otherwise set the table type based on the columns of the first page
        if (firstRow = null) then
            Table.FromRows({})
        else        
            Value.ReplaceType(
                Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
                Value.Type(firstRow[Column1])
            );


/*
    SchemaTransformTable transforms a table (such as one generated from the data returned from an API call) to conform to
    a "schema" table. A schema table defines the order that columns should appear in and the M data type for each column.
*/
EnforceSchema.Strict = 1;               // Add any missing columns, remove extra columns, set table type
EnforceSchema.IgnoreExtraColumns = 2;   // Add missing columns, do not remove extra columns
EnforceSchema.IgnoreMissingColumns = 3; // Do not add or remove columns
SchemaTransformTable = (table as table, schema as table, optional enforceSchema as number) as table =>
    let
        // Default to EnforceSchema.Strict
        _enforceSchema = if (enforceSchema <> null) then enforceSchema else EnforceSchema.Strict,

        // Applies type transforms to a given table
        EnforceTypes = (table as table, schema as table) as table =>
            let
                map = (t) => if Type.Is(t, type list) or Type.Is(t, type record) or t = type any then null else t,
                mapped = Table.TransformColumns(schema, {"Type", map}),
                omitted = Table.SelectRows(mapped, each [Type] <> null),
                existingColumns = Table.ColumnNames(table),
                removeMissing = Table.SelectRows(omitted, each List.Contains(existingColumns, [Name])),
                primativeTransforms = Table.ToRows(removeMissing),
                changedPrimatives = Table.TransformColumnTypes(table, primativeTransforms)
            in
                changedPrimatives,

        // Returns the table type for a given schema
        SchemaToTableType = (schema as table) as type =>
            let
                toList = List.Transform(schema[Type], (t) => [Type=t, Optional=false]),
                toRecord = Record.FromList(toList, schema[Name]),
                toType = Type.ForRecord(toRecord, false)
            in
                type table (toType),

        // Determine if we have extra/missing columns.
        // The enforceSchema parameter determines what we do about them.
        schemaNames = schema[Name],
        foundNames = Table.ColumnNames(table),
        addNames = List.RemoveItems(schemaNames, foundNames),
        extraNames = List.RemoveItems(foundNames, schemaNames),
        tmp = Text.NewGuid(),
        added = Table.AddColumn(table, tmp, each []),
        expanded = Table.ExpandRecordColumn(added, tmp, addNames),
        result = if List.IsEmpty(addNames) then table else expanded,
        fullList =
            if (_enforceSchema = EnforceSchema.Strict) then
                schemaNames
            else if (_enforceSchema = EnforceSchema.IgnoreMissingColumns) then
                foundNames
            else
                schemaNames & extraNames,

        // Select the final list of columns.
        // These will be ordered according to the schema table.
        reordered = Table.SelectColumns(result, fullList, MissingField.Ignore),
        enforcedTypes = EnforceTypes(reordered, schema),
        withType = if (_enforceSchema = EnforceSchema.Strict) then Value.ReplaceType(enforcedTypes, SchemaToTableType(schema)) else enforcedTypes
    in
        withType;


/*
	Table.ToNavigationTable converts a regular table to a navigation table.
*/
Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta 
        [
            NavigationTable.NameColumn = nameColumn, 
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn, 
            Preview.DelayColumn = itemNameColumn, 
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
