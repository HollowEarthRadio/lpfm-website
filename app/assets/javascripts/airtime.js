var ready;
ready = function() {
    var HERDomain = "https://hollowearth.airtime.pro/";

    $("#onAirToday").airtimeShowSchedule({
	sourceDomain: HERDomain,
	updatePeriod: 120
    });

    $("#headerLiveHolder").airtimeLiveInfo({
	sourceDomain: HERDomain,
	updatePerios: 120
    });

    $("#currentShow").airtimeCurrentShow({
	sourceDomain: HERDomain,
        text: {offline:"Offline", current:"Current Show", next:"Up Next"},
	updatePeriod: 30
    });

    $("#headerLiveTrackHolder").airtimeLiveTrackInfo({
	sourceDomain: HERDomain,
	updatePeriod: 30
    });

    $("#scheduleTabs").airtimeWeekSchedule({
	sourceDomain: HERDomain,
        miscText: {time:"Time (PST)", programName:"Program Name", details:"Details", readMore:"Read More"},
	updatePeriod: 600
    });

    var d = new Date().getDay();
    $('#scheduleTabs').tabs({selected: (d === 0 ? 6 : d-1), fx: { opacity: 'toggle' }});
}

$(document).ready(ready);
$(document).on('page:load', ready);