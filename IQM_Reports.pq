// This file contains your Data Connector logic
section IQM_Reports;

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
PAGE_SIZE = 5;     //CHANGE THIS BEFORE RELEASE!!!

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


//timezone type: a "text" type whose allowed values are the "label" strings from the TIMEZONE_TABLE (i.e. "US/Pacific", "Europe/Amsterdam"...etc)
//Used to create the timezoneLabel dropdown for the user to enter their campaign timezone.
timezone = type text meta [Documentation.AllowedValues = Table.Column(TIMEZONE_TABLE, "label")];


//The SCHEMA_TABLE table is used as a "schema" for the table that the API results from /serving/result will be placed in. 
//It defines the order of columns and the M data type of each column. 
//The ad-serving data from the /serving/result API endpoint will be placed into a table formatted according to the SCHEMA_TABLE.
SCHEMA_TABLE = #table({"Name", "Type", "Position"}, {
    {"campaignId", type text, 0},
    {"campaignName", type text, 1},
    {"date", type nullable date, 2},
    {"startTime", type nullable text, 3},
    {"endTime", type nullable text, 4},
    {"campaignTimezone", type text, 5},
    {"maxBid", type number, 6},
    {"budgetDay", type number, 7},
    {"budgetTotal", type number, 8},
    {"audioVideoViewed", type number, 9},
    {"startCount", type number, 10},
    {"firstCount", type number, 11},
    {"midCount", type number, 12},
    {"thirdCount", type number, 13},
    {"completeCount", type number, 14},
    {"impressions", type number, 15},
    {"clicks", type number, 16},
    {"mediaSpent", type number, 17},
    {"spent", type number, 18},
    {"dataCost", type number, 19},
    {"winRate", type number, 20},
    {"CTR", type number, 21},
    {"VCR", type number, 22},
    {"eCPC", type number, 23},
    {"eCPM", type number, 24},
    {"eCPCV", type number, 25}
});





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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





/*
	getServingResultsPage retrieves a page of data from the /serving/result IQM API endpoint and returns the data as an M table.
	If there is no more data to be retrieved then the function returns null.
	Parameters:
		timezoneId: The ID of a timezone (as from the IQM timezone API, or in the TIMEZONE_TABLE)
		startDateTimestamp: A Unix timestamp in milliseconds representing the start of the time interval to retrieve report data for.
		endDateTimestamp: A Unix timestamp in milliseconds representing the end of the time interval to retrieve report data for.
		pageNum: The page of results to retrieve. Page size is determined by the global PAGE_SIZE constant.
*/
getServingResultsPage = (timezoneId as number, startDateTimestamp as number, endDateTimestamp as number, pageNum as number)  as nullable table =>
    let
        requestUrl = "https://app.iqm.com/api/v2/rb/serving/result",

		//This record represents the request body.
        body = Json.FromValue([								
            total_agg = false,
            page_number = pageNum,
            total_count = PAGE_SIZE,
            request_type = "total",
            dateRange = [
                startDate = startDateTimestamp,
                endDate = endDateTimestamp
            ],
            timezone = [
                id = timezoneId
            ],
            dimension = [
                filter = [
                    value = "campaign",
                    label = "Campaigns"
                ]
            ],
            search_field = "",
            filters = [
                campaign_status = "running",
                creative_type_ids = ""
            ],
            sort_by = "impressions",
            sort_type = "desc",
            status = "running"
        ]),   //body record

		//Request headers.
        headers = [             
            #"Content-Type" = "application/json",
            #"Accept" = "application/json"
            //M engine automatically adds the Authorization header.
            //#"Authorization" = "Bearer " & Extension.CurrentCredential()[access_token]     //get access_token from current credentials set
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
	ContentsFunction generates the full table of report data from /serving/result that will be presented to the Power BI user.
	ContentsFunction repeatedly calls getServingResultsPage to gather paginated data from /serving/result until no more data is returned;
	it then gathers the paginated data into a single M table and returns it.

	Parameters are values input by the user when the user selects the IQM Reports custom connector in Power BI desktop.
	Parameters:
		timezoneLabel: A timezone label string (as from TIMEZONE_TABLE or the IQM API)
		startDate: The start of the time interval to gather ad-serving report data for.
		endDate: The end of the time interval to gather ad-serving report data for.
*/
ContentsFunction = (timezoneLabel as text, startDate as datetimezone, endDate as datetimezone) as table =>
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
		
		//startDateDuration is a value of type duration; the amount of time between the unix epoch and the start date.
        startDateDuration = startDate - UNIX_EPOCH,			
        endDateDuration = endDate - UNIX_EPOCH,
		
		//startDateTimestamp is the startDate as a Unix timestamp, expressed in milliseconds.
        startDateTimestamp = Duration.TotalSeconds(startDateDuration) * 1000,   
        endDateTimestamp = Duration.TotalSeconds(endDateDuration) * 1000,


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
						//If prevPage == null, then get the first page of results.
                        getServingResultsPage(timezoneId, startDateTimestamp, endDateTimestamp, 1)    
                    else
						//If prevPage != null, add 1 to the prevPage's page number and retrieve the next page.
                        getServingResultsPage(timezoneId, startDateTimestamp, endDateTimestamp, Value.Metadata(prevPage)[pageNum] + 1)     
            in
                nextPage,

		//Get full table of results, then enforce the schema defined in SCHEMA_TABLE
        resultTable = Table.GenerateByPage(getNextPage),
        resultTableSchemaEnforced = SchemaTransformTable(resultTable, SCHEMA_TABLE, EnforceSchema.Strict)
    in
        resultTableSchemaEnforced;


//Define the type for the IQM_Reports.Contents function, including "documentation"/helptext that will be shown to the user
ContentsFunctionType = type function (timezoneLabel as timezone, startDate as datetimezone, endDate as datetimezone) as table;


//Definitions for the connector: IQM_Reports.Contents is the connector's data source function. It is defined above as ContentsFunction.
[DataSource.Kind="IQM_Reports", Publish="IQM_Reports.Publish"]
shared IQM_Reports.Contents = Value.ReplaceType(ContentsFunction, ContentsFunctionType);

// Data Source Kind description
IQM_Reports = [
    TestConnection = (dataSourcePath) => {"IQM_Reports.Contents", dataSourcePath},
    Authentication = [
        OAuth = [
            StartLogin = StartLogin,
            FinishLogin = FinishLogin,
            Refresh = Refresh
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
// Allows the connector to appear in the "Get Data" dialog of the Power BI Desktop app
IQM_Reports.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    //LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = IQM_Reports.Icons,
    SourceTypeImage = IQM_Reports.Icons
];

//Icons for the connector are defined here.
IQM_Reports.Icons = [
    Icon16 = { Extension.Contents("IQM_Reports_16.png"), Extension.Contents("IQM_Reports_20.png"), Extension.Contents("IQM_Reports_24.png"), Extension.Contents("IQM_Reports_32.png") },
    Icon32 = { Extension.Contents("IQM_Reports_32.png"), Extension.Contents("IQM_Reports_40.png"), Extension.Contents("IQM_Reports_48.png"), Extension.Contents("IQM_Reports_64.png") }
];


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
	IQM API endpoint.

	Parameters:
		code: Authorization code or refresh token
		grant_type: "authorization_code" or "refresh_token"
		requestUrl: The URL in the IQM API to send the request to in order to exchange the auth code or refresh token for an access token

	This function returns an M record containing, at the least, an access_token and refresh_token.
	If an access token and refresh token cannot be retrieved from the IQM API, an error is thrown
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
