jQuery(document).ready(function() {
    //refresh the data every 30 seconds
    setInterval(pollstation, 30000);
    pollstation();
});

// Accepts a url and a callback function to run.
function requestCrossDomain( jsonCallback, strCallback ) {
    // Take the provided url, and add it to a YQL query. Make sure you encode it!
    // var sourceDomain = 'https://hollowearth.airtime.pro/';
    var sourceDomain = 'http://centova.rockhost.com:8001/';
    // Request that YSQL string, and run a callback function.
    // Pass a defined function to prevent cache-busting.
    getServerData();

    function currentlyPlayingJsonpError(jqXHR, textStatus, errorThrown) {
    }

    function getServerData() {
        $.getJSON(sourceDomain + "status-json.xsl")
            .done(function (jsonData) {
                jsonCallback(jsonData);
            }).fail(function (jqxhr) {
                strCallback(jqxhr.responseText);
            });
        // setTimeout(getServerData, 10000);
    }
}

function pollstation() {
    requestCrossDomain(function(jsonData) {
        var currentTrackName = "";

        if (jsonData) {
            if (jsonData.icestats != null &&
                jsonData.icestats.source != null) {
                currentTrackName = jsonData.icestats.source.title;
            } else {
                currentTrackName = "No information available.";
            }
        }
                        
        jQuery('#currentsong').html(currentTrackName);
    }, function (strData) {
        var titleRegex = /\"title\":\"([^".*])\"/;
        var notusedRegex = /([^-]*)\s*-*\s*NOTUSED\s*-*\s*([^-]*)/;

        var currentTrackMatch = /\"title\":\"([^".]*)\"/.exec(strData);
        if (currentTrackMatch !== null)
        {
            var currentTrackName = currentTrackMatch[1];

            if (notusedRegex.test(currentTrackName)) {
                var notusedMatch = notusedRegex.exec(currentTrackName);

                currentTrackName = notusedMatch[1] + " - " + notusedMatch[2];
            }
            jQuery('#currentsong').html(currentTrackName);
        }
    });
}
