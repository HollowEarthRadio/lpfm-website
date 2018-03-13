jQuery(document).ready(function() {
    //refresh the data every 30 seconds
    setInterval(pollstation, 30000);
    pollstation();
});

// Accepts a url and a callback function to run.
function requestCrossDomain( jsonCallback, strCallback ) {
    // Take the provided url, and add it to a YQL query. Make sure you encode it!
    // var sourceDomain = 'https://hollowearth.airtime.pro/';
    var sourceDomain = 'https://herhq.org:5500/';
    // Request that YSQL string, and run a callback function.
    // Pass a defined function to prevent cache-busting.
    getServerData();

    function currentlyPlayingJsonpError(jqXHR, textStatus, errorThrown) {
    }

    function getServerData() {
        $.getJSON(sourceDomain + "titles")
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
            var index = 0
            $.each(jsonData, function () {
                if (this != null)
                {
                    if (index == 0) {
                        jQuery('#currentsong').html(this[0])
                    } else {
                        jQuery('#prevsong' + index).html(this[0])
                    }

                    index++;
                }
            })
        }
    }, function (strData) {
        var titleRegex = /\"title\":\"([^\"]*)\"/;
        var notusedRegex = /([^-]*)\s*-*\s*NOTUSED\s*-*\s*([^-]*)/;

        var currentTrackMatch = titleRegex.exec(strData);
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
