jQuery(document).ready(function() {
    //refresh the data every 30 seconds
    setInterval(pollstation, 30000);
    pollstation();
});

// Accepts a url and a callback function to run.
function requestCrossDomain( callback ) {
    // Take the provided url, and add it to a YQL query. Make sure you encode it!
    // var sourceDomain = 'https://hollowearth.airtime.pro/';
    var sourceDomain = 'http://centova.rockhost.com:8001/';
    // Request that YSQL string, and run a callback function.
    // Pass a defined function to prevent cache-busting.
    getServerData();

    function currentlyPlayingJsonpError(jqXHR, textStatus, errorThrown) {
    }

    function getServerData() {
        $.getJSON(sourceDomain + "status-json.xsl", function (data) {
            cbFunc(data);
        });
        setTimeout(getServerData, 10000);
    }

    function cbFunc(data) {
        // If we have something to work with...
        if ( data ) {
            // If the user passed a callback, and it
            // is a function, call it, and send through the data var.
            if ( typeof callback === 'function') {
                callback(data);
            }
        }
    	// Else, Maybe we requested a site that doesn't exist, and nothing returned.
        else throw new Error('Nothing returned from getJSON.');
    }
}

function pollstation() {
    requestCrossDomain(function(stationData) {

        var currentTrackName = "";
        // var previousTrackName = "";        

        if ( stationData ) {
            if (stationData.icestats != null &&
                stationData.icestats.source != null) {
                currentTrackName = stationData.icestats.source.title;
            } else {
                currentTrackName = "No information available.";
            }
        }
                        
        jQuery('#currentsong').html(currentTrackName);
        //jQuery('#prevsong1').html(previousTrackName);
    } );
}
