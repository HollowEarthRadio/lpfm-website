jQuery(document).ready(function() {
    pollstation();
    //refresh the data every 30 seconds
    setInterval(pollstation, 30000);
});

// Accepts a url and a callback function to run.
function requestCrossDomain( callback ) {
    // Take the provided url, and add it to a YQL query. Make sure you encode it!
    var yql = 'http://boontdusties.com/specialhollow/yql.php?callback=?';
    // Request that YSQL string, and run a callback function.
    // Pass a defined function to prevent cache-busting.
    jQuery.getJSON( yql, cbFunc );

    function cbFunc(data) {
    // If we have something to work with...
    if ( data ) {
        // Strip out all script tags, for security reasons. there shouldn't be any, however
        data = data[0].results.replace(/<script[^>]*>[sS]*?<\/script>/gi, '');
        data = data.replace(/<html[^>]*>/gi, '');
        data = data.replace(/<\/html>/gi, '');
        data = data.replace(/<body[^>]*>/gi, '');
        data = data.replace(/<\/body>/gi, '');

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
    requestCrossDomain(function(stationdata) {
        //make our data into an array
        var lines = stationdata.split('<br/>');

        //transform the song title into [artist] - [title] ([year])
        s_info=lines[1].split(" - ");

        //remove the artist from the title
        title=jQuery.trim(s_info[0]);

        //remove the year from the title
        year = s_info[1]
        if (year != null) {
          year = year.replace(/ (d{4})/,'')
        }
        else {
          year = '';
        }
        cleantitle =  jQuery.trim(year);

        //keep just the year
        new_year=title.replace(cleantitle, '');

        //get rid of parenthesis around the year
        new_year=new_year.replace('/ (/','');
        new_year=new_year.replace('/)/','');


        //update the current artist and song title
        if ((title != '') || (cleantitle != ''))
	{
            jQuery('#currentsong').html(title + ' - ' + cleantitle);
	}

        //update the previously played songs
        for (var i = 1; i <= 10; i++) {
	    cleanline = jQuery.trim(lines[i + 1]);
	    if (cleanline != null)
	    {
		jQuery('#prevsong' + i).html(cleanline);
	    }
        }
    } );
}
