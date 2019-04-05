$(document).ready(function() {
  $('[data-toggle="tooltip"]').tooltip();
});

function getTeamId() {
  var teamLink = $('#team-link').val();

  if (teamLink.length === 0) {
    $('#team-link-input-empty-alert').removeClass('d-none');
    $('#team-id-output-group').addClass('d-none');
  } else {
    var filtered1 = teamLink.replace('https://teams.microsoft.com/l/team/', '');
    var filtered2 = (decodeURIComponent(filtered1).split('conversations')[0]).replace('/', '');

    $('#team-link-input-empty-alert').addClass('d-none');
    $('#team-id-output-group').removeClass('d-none');
    $('#team-id-output').val(filtered2);
  }
}

function copyTeamIdToClipboard() {
  $('#team-id-output').select();
  document.execCommand('copy');
}

$(document).on('click', '#get-team-id-btn', function(event) {
  event.preventDefault();
  getTeamId(event);
});

$(document).on('click', '#copy-team-id-btn', function(event) {
  event.preventDefault();
  copyTeamIdToClipboard(event);
  $("#copied-alert").fadeTo(1000, 250).slideUp(700, function() {
    $("#copied-alert").slideUp(500);
  });
});
