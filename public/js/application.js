$(document).ready(function() {

  var jobStatus = {
    isJobDone: false
  };

  function job_is_done(jid) {
    $.ajax({
      type: 'GET',
      url: '/status/' + jid
    }).done(function(data){
        console.log(data);
        jobStatus.isJobDone = data;
    });
  }


  $('form').on('submit', function(evt) {
    evt.preventDefault();
    console.log("got in!!");
    $.ajax({
      type: 'POST',
      url: '/tweet',
      data: $(this).serialize
    }).done(function(jid) {
      console.log(jid);
       $('#ajax_response').text("Got job ID" + jid);
       // var job_done = false;
       // job_done = job_is_done(jid);
       job_is_done(jid);
       // while (job_done !== true){
        // setTimeout(job_done = job_is_done(jid), 1000);
       // } 
      });
  });
});
