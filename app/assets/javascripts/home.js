$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
});

function getTeamId(event) {
  event.preventDefault();

  var teamLink = $('#team-link').val();

  if (teamLink.length === 0) {
    $('#field-empty-alert').removeClass('d-none');
    $('#team-id-group').addClass('d-none');
  } else {
    var filtered1 = teamLink.replace('https://teams.microsoft.com/l/team/', '');
    var filtered2 = decodeURIComponent(filtered1).split('@')[0];

    $('#field-empty-alert').addClass('d-none');
    $('#team-id-group').removeClass('d-none');
    $('#team-id').val(filtered2);
  }
}

function copyTeamIdToClipboard() {
  $('#team-id').select();
  document.execCommand('copy');
}

$(document).on('click', '#get-team-id-btn', function(event) {
  getTeamId(event)
});
