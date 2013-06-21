$(document).ready(function() {

  var jobStatus = {
    isJobDone: "false"
  };

  function jobIsDone(jid) {
    console.log("got into jobIsDone");
    $.ajax({
      type: 'GET',
      url: '/status/' + jid
    }).done(function(data){
        jobStatus.isJobDone = data;
        console.log(jobStatus.isJobDone);
    });
  }


  $('form').on('submit', function(evt) {
    evt.preventDefault();
    $.ajax({
      type: 'POST',
      url: '/tweet',
      data: $(this).serialize()
    }).done(function(jid) {
        var chkStatus = setInterval(function() {
          $.ajax({
          type: 'GET',
          url: '/status/' + jid
          }).done(function(data) {
            if (data == "true") {
              clearInterval(checkStatus);
            }
          });
        }, 1000);
      });
  });
});

