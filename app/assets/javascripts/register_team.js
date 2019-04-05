import asyncHandler from './vendor/asyncHandler';

function registerTeam(attributes) {
  const promiseObject = asyncHandler('/team', 'POST', attributes);
  promiseObject.then(() => {
    // Nothing to do here
  }, () => {
    // Nothing to do here
  });
}




$(document).on('click', '#register-team-btn', function(event) {
  event.preventDefault();
  registerTeam();
});
