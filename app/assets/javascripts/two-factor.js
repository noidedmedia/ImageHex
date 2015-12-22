// On Sign In page, hide normal Two-Factor code input field and show the
// Two-Factor backup code input field when the user requests it.
function twoFactorBackup() {
  // When clicking "Use a Two-Factor backup code.", hide the 2FA code field and
  // show the 2FA backup code field.
  document.getElementById("two-factor-backup-code-button").addEventListener('click', function(e) {
    e.preventDefault();
    document.getElementById("two-factor-authentication-code-input").setAttribute("hidden", true);
    document.getElementById("two-factor-authentication-backup-code-input").removeAttribute("hidden");
    document.getElementById("two-factor-authentication-backup-code-input").focus();
  });
}

var ready = function() {
  if (document.getElementById("two-factor-backup-code-button")) {
    twoFactorBackup();
  }
};

document.addEventListener('page:change', ready);
