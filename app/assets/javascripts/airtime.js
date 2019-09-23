var ready;
ready = function() {
  var HERDomain = "https://airtime.herhq.org/";

  $("#currentShow").airtimeCurrentShow({
    sourceDomain: HERDomain,
    text: { offline:"Offline", current:"Current Show", next:"Up Next" },
    updatePeriod: 600
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
