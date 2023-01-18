emailInput = document.querySelector('input[name=email]');
passInput  = document.querySelector('input[name=pass]');
form       = document.getElementById("login_form")
// loginBtn   = document.querySelector('div[aria-label="Accessible login button"]');

login = (email, pass) => {
    emailInput.value = email;
    passInput.value  = pass;
    form.submit()
};